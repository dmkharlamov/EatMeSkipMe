//
//  UIColor+EatMeSkipMe.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (EatMeSkipMe)

+ (UIColor *)colorForNavigationBarBackground;
+ (UIColor *)colorForNavigationBarText;

+ (UIColor *)colorForOnboardingBackgroundInactive;
+ (UIColor *)colorForOnboardingBackgroundActive;

+ (UIColor *)colorForOnboardingBorderInactive;
+ (UIColor *)colorForOnboardingBorderActive;

+ (UIColor *)colorForOnboardingTextInactive;
+ (UIColor *)colorForOnboardingTextActive;

+ (UIColor *)colorForOnboardingButtonBackground;
+ (UIColor *)colorForOnboardingButtonText;

@end
