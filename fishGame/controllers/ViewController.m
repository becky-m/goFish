//
//  ViewController.m
//  fishGame
//
//  Created by Rebecca Mitchell on 05/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect startBtnRect = CGRectMake(0, 10, 220, 40);
    UIImageView *startBtnImage = [[UIImageView alloc] initWithFrame:startBtnRect];
    [startBtnImage setImage:[UIImage imageNamed:@"startbtn"]];
    
    [startBtn addSubview:startBtnImage];
    //
    //
    CGRect savedBtnRect = CGRectMake(0, 10, 230, 35);
    UIImageView *savedBtnImage = [[UIImageView alloc] initWithFrame:savedBtnRect];
    [savedBtnImage setImage:[UIImage imageNamed:@"savedbtn"]];
    
    [savedBtn addSubview:savedBtnImage];
    //
    //
    CGRect leadBtnRect = CGRectMake(0, 10, 250, 35);
    UIImageView *leadBtnImage = [[UIImageView alloc] initWithFrame:leadBtnRect];
    [leadBtnImage setImage:[UIImage imageNamed:@"leaderbtn"]];
    
    [leaderBtn addSubview:leadBtnImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
