//
//  FoodIntolerancesManager.m
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import "FoodIntoleranceManager.h"

#import "EatMeSkipMeCommon.h"

#import "NSUserDefaults+EatMeSkipMe.h"


@interface FoodIntoleranceManager ()

@property (nonatomic, strong) NSMutableDictionary *foodIntolerancePreferences;
@property (nonatomic, strong, readwrite) NSMutableArray *foodIntoleranceHistory;

@end

@implementation FoodIntoleranceManager

+ (FoodIntoleranceManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static FoodIntoleranceManager *foodIntolerancesManagerSharedInstance;
    
    dispatch_once(&onceToken, ^{
        foodIntolerancesManagerSharedInstance = [[FoodIntoleranceManager alloc] init];
        
        foodIntolerancesManagerSharedInstance.foodIntolerancePreferences = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"FoodIntolerancesData"
                                                                                                                                                                         withExtension:@"json"]]
                                                                                                           options:NSJSONReadingMutableContainers
                                                                                                             error:nil];
        
        foodIntolerancesManagerSharedInstance.foodIntoleranceHistory = [[[NSUserDefaults standardUserDefaults] foodIntoleranceHistory] mutableCopy];
    });
    
    return foodIntolerancesManagerSharedInstance;
}

- (NSString *)nameForProductID:(NSString *)productID
{
    if (productID == nil) {
        return @"";
    }
    
    NSDictionary *productData = self.foodIntolerancePreferences[productID];
    
    if (productData == nil) {
        return @"";
    }
    
    return productData[@"name"] ?: @"";
}

- (FoodIntoleranceLevel)foodIntoleranceLevelForProductID:(NSString *)productID
{
    if (productID == nil) {
        return FoodIntoleranceLevelUnknown;
    }
    
    NSDictionary *productData = self.foodIntolerancePreferences[productID];
    
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

- (HistoryRecord *)makeFoodIntoleranceHistoryRecordForProductID:(NSString *)productID
{
    HistoryRecord *record = [HistoryRecord record];
    
    if (productID == nil) {
        return record;
    }
    
    record.productID = productID;
    record.name = [self nameForProductID:productID];
    record.intoleranceLevel = @([self foodIntoleranceLevelForProductID:productID]);
    record.timestamp = [NSDate date];
    
    return record;
}

- (HistoryRecord *)foodIntoleranceHistoryRecordForIndex:(NSInteger)index
{
    if (index < 0 || index > (self.foodIntoleranceHistory.count - 1)) {
        return [HistoryRecord record];
    }
    
    return self.foodIntoleranceHistory[index];
}

- (HistoryRecord *)addFoodIntoleranceHistoryRecordForProductID:(NSString *)productID
{
    HistoryRecord *record = nil;
    
    if (productID == nil) {
        record = [HistoryRecord record];
    } else {
        record = [self makeFoodIntoleranceHistoryRecordForProductID:productID];
        
        if (record != nil) {
            [self.foodIntoleranceHistory addObject:record];
        }
    }
    
    return record;
}

- (void)removeFoodIntoleranceHistoryRecord:(HistoryRecord *)record
{
    if (record != nil) {
        [self.foodIntoleranceHistory removeObject:record];
    }
}

@end
