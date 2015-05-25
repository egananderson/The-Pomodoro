//
//  AppDelegate.m
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "AppDelegate.h"
#import "AppearanceController.h"
#import "TimerViewController.h"
#import "Timer.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AppearanceController setUpDefaultAppearance];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    [[Timer sharedInstance] prepareForBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
 
     [[Timer sharedInstance] loadFromBackground];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
    }
    
    
   
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Time is up!"
//                                                                   message:@"Start next round?"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"Yes"
//                                              style:UIAlertActionStyleDefault
//                                            handler:^(
//                         [[TimerViewController sharedInstance] timerButtonPressed:nil];
//                      )]];
 
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Time is up!"
                                                                       message:@"Start next round?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
        [alert addAction:[UIAlertAction actionWithTitle:@"Yes"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundNotification object:nil];
                                                    [[Timer sharedInstance] startTimer];
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"No"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *action) {
//                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                            }]];

    
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
