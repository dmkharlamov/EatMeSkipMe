//
//  FoodIntolerancesManager.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "FoodIntolerancesManager.h"

#import "EatMeSkipMeCommon.h"

#import "NSUserDefaults+EatMeSkipMe.h"


@interface FoodIntolerancesManager ()

@property (nonatomic, strong) NSMutableDictionary *foodIntolerancesDictionary;

@end

@implementation FoodIntolerancesManager

+ (FoodIntolerancesManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static FoodIntolerancesManager *foodIntolerancesManagerSharedInstance;
    
    dispatch_once(&onceToken, ^{
        foodIntolerancesManagerSharedInstance = [[FoodIntolerancesManager alloc] init];
        
        foodIntolerancesManagerSharedInstance.foodIntolerancesDictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"FoodIntolerancesData"
                                                                                                                                                                         withExtension:@"json"]]
                                                                                                           options:NSJSONReadingMutableContainers
                                                                                                             error:nil];
    });
    
    return foodIntolerancesManagerSharedInstance;
}

- (FoodIntoleranceLevel)intolerancyLevelForProductID:(NSString *)productID
{
    NSDictionary *productData = self.foodIntolerancesDictionary[productID];
    
    if (productData == nil) {
        return FoodIntoleranceLevelUnknown;
    }
    
    NSArray *foodIntoleranceTypes = productData[@"intolerances"];
    
    if (foodIntoleranceTypes == nil) {
        return FoodIntoleranceLevelUnknown;
    }
    
    for (NSString *typeName in foodIntoleranceTypes) {
        FoodIntoleranceType type = foodIntoleranceTypeForName(typeName);
        
        FoodIntoleranceState state = [[NSUserDefaults standardUserDefaults] foodIntoleranceStateForFoodIntoleranceType:type];
        
        if (state == FoodIntoleranceStateActive) {
            return FoodIntoleranceLevelBad;
        }
    }
    
    return FoodIntoleranceLevelGood;
}

@end
