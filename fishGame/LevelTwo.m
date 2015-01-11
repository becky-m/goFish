//
//  LevelTwo.m
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "LevelTwo.h"

@interface LevelTwo ()

@end

@implementation LevelTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"GOFISH: Level Two";
    [super setNumberOfFish:10];
    beginLevel.hidden = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(loop) userInfo:nil repeats:YES];
    
    [coverBtn addTarget:self action:@selector(remove:)
     forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction) remove: (UIButton*)selector {
    levelTwobtn.hidden = YES;
}

-(void) loop {

    if([super userTap] == TRUE) {
        beginLevel.hidden = YES;
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
