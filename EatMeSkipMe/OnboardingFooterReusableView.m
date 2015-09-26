//
//  OnboardingFooterReusableView.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "OnboardingFooterReusableView.h"

#import "UIColor+EatMeSkipMe.h"

@interface OnboardingFooterReusableView ()

@property (nonatomic, weak) IBOutlet UIButton *actionButton;

@end

@implementation OnboardingFooterReusableView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.actionButton.backgroundColor = [UIColor colorForOnboardingButtonBackground];
    [self.actionButton setTitleColor:[UIColor colorForOnboardingButtonText] forState:UIControlStateNormal];
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Proceed" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],
                                                                                                   NSForegroundColorAttributeName: [UIColor colorForOnboardingButtonText],
                                                                                                   NSKernAttributeName: @4}];
    
    [self.actionButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (IBAction)buttonAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onboardingFooterButtonAction:)])
    {
        [self.delegate onboardingFooterButtonAction:self];
    }
}

@end
