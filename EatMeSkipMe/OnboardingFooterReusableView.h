//
//  OnboardingFooterReusableView.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OnboardingFooterReusableView;

@protocol OnboardingFooterDelegate <NSObject>

@optional
- (void)onboardingFooterButtonAction:(OnboardingFooterReusableView *)footer;

@end


@interface OnboardingFooterReusableView : UICollectionReusableView

@property (nonatomic, weak)	id<OnboardingFooterDelegate> delegate;

@end
