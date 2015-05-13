//
//  FirstViewController.m
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"
#import "Rounds.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation TimerViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerForNotifications];
    }
    return self;
}

-(void) dealloc{
    [self unregisterForNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  [self registerForNotifications];
    if (![Rounds sharedInstance].currentRound) {
        [Timer sharedInstance].minutes = [[[Rounds sharedInstance] getRoundTimes][0] integerValue];
        [Timer sharedInstance].seconds = 0;
        [self updateTimer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateTimer{
    
    NSInteger seconds = [Timer sharedInstance].seconds;
    NSInteger minutes = [Timer sharedInstance].minutes;
    NSString *timer;
    
    if (seconds <10) {
        timer = [NSString stringWithFormat:@"%li:0%li",(long)minutes,(long)seconds];
    }
    
    else {
        timer = [NSString stringWithFormat:@"%li:%li",(long)minutes,(long)seconds];
    }
    self.timerLabel.text = timer;
}

-(void) newRound{
    [self updateTimer];
    self.startButton.enabled = YES;
}


-(void) registerForNotifications{
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateTimer)
               name:SecondTickNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(newRound)
               name:NewRoundNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(newRound)
               name:TimerCompleteNotification
             object:nil];
}

-(void) unregisterForNotifications{
      NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (IBAction)timerButtonPressed:(id)sender {
    self.startButton.enabled = NO;
    [[Timer sharedInstance] startTimer];
}

@end
