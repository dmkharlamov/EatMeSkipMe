//
//  CameraResponseView.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "CameraResponseView.h"

@implementation CameraResponseView

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
        case CameraResponseTypeOff:
            self.backgroundColor = [UIColor clearColor];
            
            break;
        case CameraResponseTypeGood:
            self.backgroundColor = [UIColor greenColor];
            
            break;
        case CameraResponseTypeUnknown:
            self.backgroundColor = [UIColor yellowColor];
            
            break;
        case CameraResponseTypeBad:
            self.backgroundColor = [UIColor redColor];
            
            break;
            
        default:
            break;
    }
}

@end
