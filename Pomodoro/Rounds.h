//
//  Rounds.h
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Rounds : NSObject
@property (nonatomic, strong) NSArray *roundTimes;
@property (nonatomic, assign) NSInteger currentRound;
@property (nonatomic, assign) NSIndexPath *currentIndexPath;

+ (instancetype)sharedInstance;
- (NSArray*)getRoundTimes;
@end
