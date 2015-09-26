//
//  CameraResponseView.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, CameraResponseType) {
    CameraResponseTypeOff = 0,
    CameraResponseTypeGood,
    CameraResponseTypeOK,
    CameraResponseTypeBad,
    CameraResponseTypeCount
};


@interface CameraResponseView : UIView

@property (nonatomic, assign) CameraResponseType responseType;

@end
