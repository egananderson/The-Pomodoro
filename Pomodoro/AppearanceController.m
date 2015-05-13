//
//  AppearanceController.m
//  Pomodoro
//
//  Created by Egan Anderson on 5/12/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "AppearanceController.h"
#import "TimerViewController.h"
@import UIKit;

@implementation AppearanceController

+(void)setUpDefaultAppearance{
    
    [[UILabel appearance] setTextColor:[UIColor whiteColor]];
    [[UILabel appearance] setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Thin"  size:80]];
   

    [[UIButton appearance] setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : [UIColor redColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:20]
                                                           }];
    
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    
    [[UITableViewCell appearance] setTintColor:[UIColor redColor]];
    
    
    [[UIButton appearance] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[UIView appearanceWhenContainedIn:[TimerViewController class], nil] setBackgroundColor:[UIColor redColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

@end
