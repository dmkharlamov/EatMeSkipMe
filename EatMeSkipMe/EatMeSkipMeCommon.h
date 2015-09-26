//
//  EatMeSkipMeCommon.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/25/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FoodIntoleranceType) {
    FoodIntoleranceTypeAlcohol = 0,
    FoodIntoleranceTypeCelery,
    FoodIntoleranceTypeCrustacean,
    FoodIntoleranceTypeFish,
    FoodIntoleranceTypeGluten,
    FoodIntoleranceTypeLupin,
    FoodIntoleranceTypeMilk,
    FoodIntoleranceTypeMolluscs,
    FoodIntoleranceTypeNuts,
    FoodIntoleranceTypeSeasame,
    FoodIntoleranceTypeTomatoes,
    FoodIntoleranceTypeYeast,
    FoodIntoleranceTypeCount,
    FoodIntoleranceTypeNone
};

typedef NS_ENUM(NSUInteger, FoodIntoleranceState) {
    FoodIntoleranceStateInactive = 0,
    FoodIntoleranceStateActive,
    FoodIntoleranceStateCount
};

typedef NS_ENUM(NSUInteger, FoodIntoleranceLevel) {
    FoodIntoleranceLevelGood = 0,
    FoodIntoleranceLevelUnknown,
    FoodIntoleranceLevelBad
};

typedef NS_ENUM(NSUInteger, CameraResponseType) {
    CameraResponseTypeOff = 0,
    CameraResponseTypeGood,
    CameraResponseTypeUnknown,
    CameraResponseTypeBad,
    CameraResponseTypeCount
};

// Storyboard segue IDs
extern NSString * const kOnboardingToCameraSegueID;

NSString *nameForFoodIntoleranceType(FoodIntoleranceType type);
FoodIntoleranceType foodIntoleranceTypeForName(NSString * name);
FoodIntoleranceState invertedStateForFoodIntoleranceState(FoodIntoleranceState state);
CameraResponseType cameraResponseTypeForFoodIntoleranceLevel(FoodIntoleranceLevel level);

@interface EatMeSkipMeCommon : NSObject

@end
