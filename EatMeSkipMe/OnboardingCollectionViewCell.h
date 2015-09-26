//
//  OnboardingCollectionViewCell.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EatMeSkipMeCommon.h"


@interface OnboardingCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) FoodIntoleranceState foodIntoleranceState;
@property (nonatomic, strong) NSString *foodIntoleranceName;

@end
