//
//  Rounds.m
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "Rounds.h"
#import "Timer.h"

@implementation Rounds

@synthesize roundTimes = _roundTimes;

- (NSArray*)getRoundTimes{
    self.roundTimes = @[@25,@5,@25,@5,@25,@5,@25,@15];
    return self.roundTimes;
}




+ (instancetype)sharedInstance{
    static Rounds *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Rounds alloc]init];
        sharedInstance.currentRound = 0;
    });
    
    return sharedInstance;
        
    }

@end
