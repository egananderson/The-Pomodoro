//
//  Timer.h
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *SecondTickNotification = @"secondTick";
static NSString *TimerCompleteNotification = @"timerComplete";
static NSString *NewRoundNotification = @"newRound";

@interface Timer : NSObject
@property (nonatomic) NSInteger minutes;
@property (nonatomic) NSInteger seconds;

+ (instancetype)sharedInstance;
-(void) startTimer;
-(void) endTimer;
-(void) cancelTimer;

@end
