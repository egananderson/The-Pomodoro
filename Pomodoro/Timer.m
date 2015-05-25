//
//  Timer.m
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "Timer.h"
#import "RoundsViewController.h"
@import UIKit;

@interface Timer ()
@property (nonatomic,assign) BOOL isOn;
@property (nonatomic, strong)NSDate *experationDate;


@end
@implementation Timer


-(void) startTimer{
    self.isOn = YES;
    [self checkActive];
    
    self.experationDate = [[NSDate new] dateByAddingTimeInterval:(self.minutes *60)];
    
    UILocalNotification *localNotification = [UILocalNotification new];
    
    localNotification.fireDate = self.experationDate;
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.soundName = @"bell_tree.mp3";
    
    localNotification.alertBody = @"Time is up!";
    localNotification.alertTitle = @"Time!";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
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
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

+ (instancetype)sharedInstance{
    static Timer *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc]init];

    });
    
    return sharedInstance;
}

-(void) prepareForBackground{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.experationDate forKey:experationDate];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void) loadFromBackground{
    
    self.experationDate = [[NSUserDefaults standardUserDefaults]objectForKey:experationDate];
    
    NSTimeInterval seconds =[self.experationDate timeIntervalSinceNow];
    
    self.minutes = seconds / 60;
    
    self.seconds = seconds - (self.minutes *60);
    
}


@end
