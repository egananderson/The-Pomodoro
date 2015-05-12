//
//  SecondViewController.m
//  Pomodoro
//
//  Created by Owner on 5/11/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "RoundsViewController.h"
#import "Rounds.h"
#import "Timer.h"

static NSString *cellID = @"cellID";

@interface RoundsViewController () <UITableViewDataSource, UITableViewDelegate>;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation RoundsViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    NSArray *cellRounds = [[Rounds sharedInstance] getRoundTimes];
    
    NSNumber *minutes = cellRounds [indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld minutes", (long)[minutes integerValue]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[Rounds sharedInstance] getRoundTimes].count;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [Rounds sharedInstance].currentRound = indexPath.row;
    [Rounds sharedInstance].currentIndexPath = indexPath;
    [self roundSelected];
    [[Timer sharedInstance] cancelTimer];
}

-(void)roundSelected{
    
    [Timer sharedInstance].seconds = 0;
    NSInteger index = [Rounds sharedInstance].currentRound;
    [Timer sharedInstance].minutes = [[[Rounds sharedInstance] getRoundTimes][index] integerValue];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundNotification object:nil];
    
    [self.tabBarController setSelectedIndex:0];
    
}

-(void) roundComplete{
    if([Rounds sharedInstance].currentRound < [[Rounds sharedInstance]getRoundTimes].count - 1){
        
        NSInteger nexRow =[Rounds sharedInstance].currentRound ++;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nexRow inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [self roundSelected];
        
    } else{
        [Rounds sharedInstance].currentRound = 0;
        [self roundSelected];
       
    }
}
    
-(void)registerForNotifications{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(roundComplete)
               name:TimerCompleteNotification
             object:nil];
}
     


- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForNotifications];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
