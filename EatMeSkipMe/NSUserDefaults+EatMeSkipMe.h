//
//  NSUserDefaults+EatMeSkipMe.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EatMeSkipMeCommon.h"


@interface NSUserDefaults (EatMeSkipMe)

- (FoodIntoleranceState)foodIntoleranceStateForFoodIntoleranceType:(FoodIntoleranceType)type;
- (void)setFoodIntoleranceState:(FoodIntoleranceState)state forFoodIntoleranceType:(FoodIntoleranceType)type;

@end
