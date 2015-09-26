//
//  NSUserDefaults+EatMeSkipMe.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "NSUserDefaults+EatMeSkipMe.h"

@implementation NSUserDefaults (EatMeSkipMe)

- (NSString *)keyForFoodIntoleranceType:(FoodIntoleranceType)type
{
    return [NSString stringWithFormat:@"foodIntoleranceType%lu", (NSInteger)type];
}

- (NSString *)keyForFoodIntoleranceHistory
{
    return @"foodIntoleranceHistory";
}

- (FoodIntoleranceState)foodIntoleranceStateForFoodIntoleranceType:(FoodIntoleranceType)type
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:[self keyForFoodIntoleranceType:type]] integerValue];
}

- (void)setFoodIntoleranceState:(FoodIntoleranceState)state forFoodIntoleranceType:(FoodIntoleranceType)type
{
    [[NSUserDefaults standardUserDefaults] setObject:@(state)
                                              forKey:[self keyForFoodIntoleranceType:type]];
}

- (NSArray *)foodIntoleranceHistory
{
    NSArray *history = [[NSUserDefaults standardUserDefaults] objectForKey:[self keyForFoodIntoleranceHistory]];

    return history ?: @[];
}

- (void)setFoodIntoleranceHistory:(NSArray *)history
{
    if (history != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:history
                                                  forKey:[self keyForFoodIntoleranceHistory]];
    }
}

@end
