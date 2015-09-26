//
//  CameraViewController.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraResponseView.h"

#import "FoodIntoleranceManager.h"

#import "EatMeSkipMeCommon.h"

@import AVFoundation;


static NSString * const kCameraToHistorySegueID = @"cameraToHistorySegueID";

static NSTimeInterval kEatMeSkipMeCameraResponseInterval = 1;


@interface CameraViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, weak) IBOutlet UIView *previewView;
@property (nonatomic, strong) IBOutlet CameraResponseView *responseView;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;

@property (nonatomic, assign) BOOL running;
@property (nonatomic, strong) NSString *currentProductID;

@property (nonatomic, strong) NSTimer *responseUpdateTimer;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCaptureSession];
    self.previewLayer.frame = self.view.bounds;
    [self.previewView.layer addSublayer:self.previewLayer];
    
    // listen for going into the background and stop the session
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.previewLayer.frame = self.previewView.frame;
    
    [self startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopResponseUpdateTimer];
    
    [self stopRunning];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.previewLayer.connection.videoOrientation = (AVCaptureVideoOrientation)[UIApplication sharedApplication].statusBarOrientation;
        
        self.previewLayer.frame = self.previewView.bounds;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -

- (IBAction)buttonHistory:(id)sender
{
    [self performSegueWithIdentifier:kCameraToHistorySegueID sender:self];
}

#pragma mark - AV capture methods

- (void)setupCaptureSession {
    // 1
    if (self.captureSession) return;
    // 2
    self.videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!self.videoDevice) {
        NSLog(@"No video camera on this device!");
        return;
    }
    // 3
    self.captureSession = [[AVCaptureSession alloc] init];
    // 4
    self.videoInput = [[AVCaptureDeviceInput alloc]
                   initWithDevice:self.videoDevice error:nil];
    // 5
    if ([self.captureSession canAddInput:self.videoInput]) {
        [self.captureSession addInput:self.videoInput];
    }
    // 6
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // capture and process the metadata
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    dispatch_queue_t metadataQueue = dispatch_queue_create("com.zone.EatMeSkipMe.metadata", 0);
    [self.metadataOutput setMetadataObjectsDelegate:self
                                              queue:metadataQueue];
    if ([self.captureSession canAddOutput:self.metadataOutput]) {
        [self.captureSession addOutput:self.metadataOutput];
    }
}

- (void)startRunning {
    if (self.running) return;
    [self.captureSession startRunning];
    self.metadataOutput.metadataObjectTypes =
    self.metadataOutput.availableMetadataObjectTypes;
    self.running = YES;
}
- (void)stopRunning {
    if (!self.running) return;
    [self.captureSession stopRunning];
    self.running = NO;
}

//  handle going foreground/background
- (void)applicationWillEnterForeground:(NSNotification*)note {
    [self startRunning];
}
- (void)applicationDidEnterBackground:(NSNotification*)note {
    [self stopRunning];
}

#pragma mark - Message thread polling timer

- (void)startResponseUpdateTimer
{
    [self.responseUpdateTimer invalidate];
    
    self.responseUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:kEatMeSkipMeCameraResponseInterval
                                                                       target:self
                                                                     selector:@selector(responseUpdateTimerFire:)
                                                                     userInfo:nil
                                                                      repeats:NO];
}

- (void)stopResponseUpdateTimer
{
    [self.responseUpdateTimer fire];
    
    [self.responseUpdateTimer invalidate];
}

- (void)responseUpdateTimerFire:(NSTimer *)timer
{
    self.responseView.responseType = CameraResponseTypeOff;
    self.currentProductID = nil;
}

#pragma mark - Delegate functions

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    [metadataObjects
     enumerateObjectsUsingBlock:^(AVMetadataObject *obj,
                                  NSUInteger idx,
                                  BOOL *stop)
     {
         if ([obj isKindOfClass:
              [AVMetadataMachineReadableCodeObject class]])
         {
             AVMetadataMachineReadableCodeObject *code =
             (AVMetadataMachineReadableCodeObject*)
             [self.previewLayer transformedMetadataObjectForMetadataObject:obj];
             
             if (![self.currentProductID isEqualToString:code.stringValue]) {
                 self.currentProductID = code.stringValue;
                 
                 FoodIntoleranceLevel level = [[FoodIntoleranceManager sharedManager] foodIntoleranceLevelForProductID:code.stringValue];
                 
                 [[FoodIntoleranceManager sharedManager] addFoodIntoleranceHistoryRecordForProductID:self.currentProductID];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     self.responseView.responseType = cameraResponseTypeForFoodIntoleranceLevel(level);
                 });
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self startResponseUpdateTimer];
             });
         }
     }];
}

@end
