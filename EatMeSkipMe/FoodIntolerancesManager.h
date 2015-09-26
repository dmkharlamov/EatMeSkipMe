//
//  FoodIntolerancesManager.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EatMeSkipMeCommon.h"


@interface FoodIntolerancesManager : NSObject

+ (FoodIntolerancesManager *)sharedManager;

- (FoodIntoleranceLevel)intolerancyLevelForProductID:(NSString *)productID;

@end
