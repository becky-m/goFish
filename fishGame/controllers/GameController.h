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
    
    BOOL beginPressed; 
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
@property(nonatomic) int numberOfFish;
    
@property(nonatomic) bool userTap;
    
@property(nonatomic) MenuBar *menuInstance;

-(IBAction)StartButton:(id)sender;
-(void)sceneMovement;
-(void)tapRecognition;
-(void)Collision;
-(void)addScore: (int)scorevalue;
-(void)setUpNavigationBar;
-(IBAction)back:(id)sender;
-(void) setNumberOfFish:(int)numberOfFish :(int)end;
-(int) getScoreValue;
-(BOOL) beginSelected;
-(void)setFishImageType:(int)fishImageType;
-(void) levelOne: (int)numberOfFish: (int)end;

@end
