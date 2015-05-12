//
//  Timer.m
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "Timer.h"
#import "RoundsViewController.h"

@interface Timer ()
@property (nonatomic,assign) BOOL isOn;


@end
@implementation Timer


-(void) startTimer{
    self.isOn = YES;
    [self checkActive];
}

-(void) endTimer{
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerCompleteNotification object:nil];
}

-(void) decreaseSecond{

    if (self.seconds >0) {
        self.seconds --;
        [[NSNotificationCenter defaultCenter] postNotificationName: SecondTickNotification object:self userInfo:nil];
    } else if (self.minutes >0 && self.seconds == 0){
        self.minutes --;
        self.seconds = 59;
        
        [[NSNotificationCenter defaultCenter] postNotificationName: SecondTickNotification object:self userInfo:nil];
        
    } else {
        [self endTimer];
    }

}

-(void) checkActive{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (self.isOn){
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1.0];
    }
}

-(void) cancelTimer{
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

+ (instancetype)sharedInstance{
    static Timer *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc]init];

    });
    
    return sharedInstance;
}

@end
