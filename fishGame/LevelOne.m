//
//  LevelOne.m
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "LevelOne.h"

@interface LevelOne ()

@end

@implementation LevelOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"GOFISH: Level One";
    [super setNumberOfFish:5 :1 :1];
    
    nextLevel.hidden = YES;
 
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(loop) userInfo:nil repeats:YES];
}

-(void) loop {
    
    int completedScore = [super getScoreValue];
    
    if (completedScore == 5) {
        nextLevel.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
