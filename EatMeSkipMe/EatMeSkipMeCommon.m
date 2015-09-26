//
//  EatMeSkipMeCommon.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "EatMeSkipMeCommon.h"


// Storyboard segue IDs
NSString * const kOnboardingToCameraSegueID = @"onboardingToCameraSegueID";


NSString *nameForFoodIntoleranceType(FoodIntoleranceType type)
{
    switch (type) {
        case FoodIntoleranceTypeMilk:
            return @"MILK";
        case FoodIntoleranceTypeAlcohol:
            return @"ALCOHOL";
        case FoodIntoleranceTypeCrustacean:
            return @"CRUSTACEAN";
        case FoodIntoleranceTypeGluten:
            return @"GLUTEN";
        case FoodIntoleranceTypeYeast:
            return @"YEAST";
        case FoodIntoleranceTypeMolluscs:
            return @"MOLLUSCS";
        case FoodIntoleranceTypeNuts:
            return @"NUTS";
        case FoodIntoleranceTypeSeasame:
            return @"SEASAME";
        case FoodIntoleranceTypeFish:
            return @"FISH";
        case FoodIntoleranceTypeTomatoes:
            return @"TOMATOES";
        case FoodIntoleranceTypeLupin:
            return @"LUPIN";
        case FoodIntoleranceTypeCelery:
            return @"CELERY";
            
        default:
            return @"";
    }
}

FoodIntoleranceType foodIntoleranceTypeForName(NSString * name)
{
    if ([name isEqualToString:@"MILK"]) {
        return FoodIntoleranceTypeMilk;
    } else if ([name isEqualToString:@"ALCOHOL"]) {
        return FoodIntoleranceTypeAlcohol;
    } else if ([name isEqualToString:@"CRUSTACEAN"]) {
        return FoodIntoleranceTypeCrustacean;
    } else if ([name isEqualToString:@"GLUTEN"]) {
        return FoodIntoleranceTypeGluten;
    } else if ([name isEqualToString:@"YEAST"]) {
        return FoodIntoleranceTypeYeast;
    } else if ([name isEqualToString:@"MOLLUSCS"]) {
        return FoodIntoleranceTypeMolluscs;
    } else if ([name isEqualToString:@"NUTS"]) {
        return FoodIntoleranceTypeNuts;
    } else if ([name isEqualToString:@"SEASAME"]) {
        return FoodIntoleranceTypeSeasame;
    } else if ([name isEqualToString:@"FISH"]) {
        return FoodIntoleranceTypeFish;
    } else if ([name isEqualToString:@"TOMATOES"]) {
        return FoodIntoleranceTypeTomatoes;
    } else if ([name isEqualToString:@"LUPIN"]) {
        return FoodIntoleranceTypeTomatoes;
    } else if ([name isEqualToString:@"CELERY"]) {
        return FoodIntoleranceTypeTomatoes;
    }
    
    return FoodIntoleranceTypeNone;
}

FoodIntoleranceState invertedStateForFoodIntoleranceState(FoodIntoleranceState state)
{
    switch (state) {
        case FoodIntoleranceStateInactive:
            return FoodIntoleranceStateActive;
        case FoodIntoleranceStateActive:
        default:
            return FoodIntoleranceStateInactive;
    }
}

CameraResponseType cameraResponseTypeForFoodIntoleranceLevel(FoodIntoleranceLevel level)
{
    switch (level) {
        case FoodIntoleranceLevelGood:
            return CameraResponseTypeGood;
        case FoodIntoleranceLevelUnknown:
            return CameraResponseTypeUnknown;
        case FoodIntoleranceLevelBad:
            return CameraResponseTypeBad;
            
        default:
            return CameraResponseTypeOff;
    }
}

@implementation EatMeSkipMeCommon

@end
