//
//  FoodIntolerancesManager.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EatMeSkipMeCommon.h"

#import "HistoryRecord.h"


@interface FoodIntoleranceManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *foodIntoleranceHistory;


+ (FoodIntoleranceManager *)sharedManager;

- (NSString *)nameForProductID:(NSString *)productID;
- (FoodIntoleranceLevel)foodIntoleranceLevelForProductID:(NSString *)productID;

- (HistoryRecord *)makeFoodIntoleranceHistoryRecordForProductID:(NSString *)productID;
- (HistoryRecord *)foodIntoleranceHistoryRecordForIndex:(NSInteger)index;

- (HistoryRecord *)addFoodIntoleranceHistoryRecordForProductID:(NSString *)productID;
- (void)removeFoodIntoleranceHistoryRecord:(HistoryRecord *)record;

@end
