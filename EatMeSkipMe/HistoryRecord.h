//
//  HistoryRecord.h
//  EatMeSkipMe
//
//  Created by Dmitri Kharlamov on 9/26/15.
//  Copyright © 2015 Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryRecord : NSObject

@property (nonatomic, strong) NSString *productID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *intoleranceLevel;
@property (nonatomic, strong) NSDate *timestamp;

+ (instancetype)record;

@end
