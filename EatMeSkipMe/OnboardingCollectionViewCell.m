//
//  OnboardingCollectionViewCell.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "OnboardingCollectionViewCell.h"

#import "EatMeSkipMeCommon.h"

#import "UIColor+EatMeSkipMe.h"

@interface OnboardingCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *foodToleranceNameLabel;

@end

@implementation OnboardingCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.foodToleranceNameLabel.layer.cornerRadius = CGRectGetHeight(self.foodToleranceNameLabel.frame)/2;
    self.foodToleranceNameLabel.layer.borderWidth = 2.0;
    self.foodToleranceNameLabel.clipsToBounds = YES;
}

- (void)setFoodIntoleranceName:(NSString *)foodIntoleranceName
{
    _foodIntoleranceName = foodIntoleranceName;
    
    self.foodToleranceNameLabel.text = foodIntoleranceName;
}

- (void)setFoodIntoleranceState:(FoodIntoleranceState)foodIntoleranceState
{
    _foodIntoleranceState = foodIntoleranceState;
    
    switch (foodIntoleranceState) {
        case FoodIntoleranceStateInactive:
            self.foodToleranceNameLabel.backgroundColor = [UIColor colorForOnboardingBackgroundInactive];
            self.foodToleranceNameLabel.layer.borderColor = [UIColor colorForOnboardingBorderInactive].CGColor;
            self.foodToleranceNameLabel.textColor = [UIColor colorForOnboardingTextInactive];
            
            break;
        case FoodIntoleranceStateActive:
        default:
            self.foodToleranceNameLabel.backgroundColor = [UIColor colorForOnboardingBackgroundActive];
            self.foodToleranceNameLabel.layer.borderColor = [UIColor colorForOnboardingBorderActive].CGColor;
            self.foodToleranceNameLabel.textColor = [UIColor colorForOnboardingTextActive];
            
            break;
    }
}

@end
