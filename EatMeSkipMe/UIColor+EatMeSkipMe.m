//
//  UIColor+EatMeSkipMe.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "UIColor+EatMeSkipMe.h"

@implementation UIColor (EatMeSkipMe)

+ (UIColor *)colorForEatMeDrinkMeBlue
{
    return [UIColor colorWithRed:54.0/255.0 green:66.0/255.0 blue:89.0/255.0 alpha:1.0];
}

+ (UIColor *)colorForEatMeDrinkMeRed
{
    return [UIColor colorWithRed:247.0/255.0 green:60.0/255.0 blue:70.0/255.0 alpha:1.0];
}

+ (UIColor *)colorForEatMeDrinkMeGrey
{
    return [UIColor colorWithRed:207.0/255.0 green:207.0/255.0 blue:207.0/255.0 alpha:1.0];
}

+ (UIColor *)colorForNavigationBarBackground
{
    return [UIColor colorForEatMeDrinkMeGrey];
}

+ (UIColor *)colorForNavigationBarText
{
    return [UIColor colorForEatMeDrinkMeBlue];
}

+ (UIColor *)colorForOnboardingBackgroundInactive
{
    return [UIColor whiteColor];
}

+ (UIColor *)colorForOnboardingBackgroundActive
{
    return [UIColor colorForEatMeDrinkMeBlue];
}

+ (UIColor *)colorForOnboardingBorderInactive
{
    return [UIColor colorForEatMeDrinkMeBlue];
}

+ (UIColor *)colorForOnboardingBorderActive
{
    return [UIColor colorForEatMeDrinkMeBlue];
}

+ (UIColor *)colorForOnboardingTextInactive
{
    return [UIColor colorForEatMeDrinkMeBlue];
}

+ (UIColor *)colorForOnboardingTextActive
{
    return [UIColor whiteColor];
}

+ (UIColor *)colorForUnreadMessagesBadgeBackground
{
    return [UIColor colorWithRed:235.0/255.0 green:137.0/255.0 blue:129.0/255.0 alpha:1.0];
}

+ (UIColor *)colorForOnboardingButtonBackground
{
    return  [UIColor colorForEatMeDrinkMeRed];
}

+ (UIColor *)colorForOnboardingButtonText
{
    return [UIColor whiteColor];
}

@end
