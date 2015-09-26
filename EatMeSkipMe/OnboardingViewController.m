//
//  OnboardingViewController.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "OnboardingViewController.h"
#import "OnboardingCollectionViewCell.h"
#import "OnboardingFooterReusableView.h"

#import "EatMeSkipMeCommon.h"

#import "NSUserDefaults+EatMeSkipMe.h"


static CGSize const kOnboardingCellSize = {100.0, 100.0};
static UIEdgeInsets const kOnboardingCellInsets = {30, 10, 40, 10};


static NSString * const kOnboardingCellID = @"onboardingCellID";
static NSString * const kOnboardingHeaderID = @"onboardingHeaderID";
static NSString * const kOnboardingFooterID = @"onboardingFooterID";


@interface OnboardingViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
OnboardingFooterDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *onboardingCollectionView;

@property (nonatomic, assign) CGSize defaultOnboardingCellSize;

@end

@implementation OnboardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.defaultOnboardingCellSize = kOnboardingCellSize;
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

#pragma mark - OnboardingFooterDelegate

- (void)onboardingFooterButtonAction:(OnboardingFooterReusableView *)footer
{
    [self performSegueWithIdentifier:kOnboardingToCameraSegueID sender:self];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodIntoleranceType type = indexPath.row;
    
    FoodIntoleranceState state = [[NSUserDefaults standardUserDefaults] foodIntoleranceStateForFoodIntoleranceType:type];
    
    [[NSUserDefaults standardUserDefaults] setFoodIntoleranceState:invertedStateForFoodIntoleranceState(state)
                                            forFoodIntoleranceType:type];
    
    [self.onboardingCollectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return kOnboardingCellInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat currentViewWidth = CGRectGetWidth(collectionView.frame);
    CGFloat requestedViewWidth = (self.defaultOnboardingCellSize.width + kOnboardingCellInsets.left) * 3 + kOnboardingCellInsets.right;
    
    if (requestedViewWidth > currentViewWidth) {
        CGSize optimalSize = self.defaultOnboardingCellSize;
        
        optimalSize.width = currentViewWidth / 3 - kOnboardingCellInsets.left - kOnboardingCellInsets.right / 2;
        optimalSize.height -= self.defaultOnboardingCellSize.width - optimalSize.width;
        
        self.defaultOnboardingCellSize = optimalSize;
        return optimalSize;
    }
    
    return self.defaultOnboardingCellSize;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return FoodIntoleranceTypeCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OnboardingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kOnboardingCellID
                                                                                   forIndexPath:indexPath];
    FoodIntoleranceType type = indexPath.row;
    
    FoodIntoleranceState state = [[NSUserDefaults standardUserDefaults] foodIntoleranceStateForFoodIntoleranceType:type];
    
    cell.foodIntoleranceState = state;
    cell.foodIntoleranceName = nameForFoodIntoleranceType(type);
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier = [self reuseIdentifierForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    OnboardingFooterReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    view.delegate = self;
    
    return view;
}

- (NSString *)reuseIdentifierForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuseIdentifier = kOnboardingHeaderID;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reuseIdentifier = kOnboardingFooterID;
    }
    
    return reuseIdentifier;
}

@end
