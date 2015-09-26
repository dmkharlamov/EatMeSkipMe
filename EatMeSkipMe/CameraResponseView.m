//
//  CameraResponseView.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "CameraResponseView.h"

@interface CameraResponseView ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end


@implementation CameraResponseView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setResponseType:(CameraResponseType)responseType
{
    _responseType = responseType;
    
    switch (responseType) {
        case CameraResponseTypeGood:
            self.imageView.image = [UIImage imageNamed:@"CameraResponseTypeGood"];
            
            break;
        case CameraResponseTypeUnknown:
            self.imageView.image = [UIImage imageNamed:@"CameraResponseTypeUnknown"];
            
            break;
        case CameraResponseTypeBad:
            self.imageView.image = [UIImage imageNamed:@"CameraResponseTypeBad"];
            
            break;
        case CameraResponseTypeOff:
        default:
            self.imageView.image = nil;
            
            break;
    }
}

@end
