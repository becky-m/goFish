//
//  GameController.h
//  fishGame
//
//  Created by Rebecca Mitchell on 05/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hook.h"
#import "Fish.h"
#import "FishingLine.h"
#import "MenuBar.h"

@interface GameController : UIViewController {

    IBOutlet UIButton *begin;
    IBOutlet UILabel *score;
    IBOutlet UIButton *menuButton;
}
    
@property(nonatomic, strong) UIImageView *beginBtnImage;
    
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) Hook *hookInstance;
@property(nonatomic, strong) Fish *fishInstance;
@property(nonatomic, strong) FishingLine *fishingLineInstance;
    
@property(nonatomic) int scoreValue;
@property(nonatomic, strong) UIImageView *fish;
@property(nonatomic, strong) UIImageView *hook;
@property(nonatomic, strong) NSMutableArray *fishArray;
@property(nonatomic) CGRect hookFrame;
@property(nonatomic) CGRect fishFrame;
@property(nonatomic) CGRect lineFrame;
@property(nonatomic) BOOL reset;
@property(nonatomic) int whichFish;
@property(nonatomic)  bool hasCollided;
    
@property(nonatomic) bool userTap;
    
@property(nonatomic) MenuBar *menuInstance;

-(IBAction)StartButton:(id)sender;
-(void)sceneMovement;
-(void)tapRecognition;
-(void)Collision;
-(void)addScore;
-(void)setUpNavigationBar;
-(IBAction)back:(id)sender;

@end
