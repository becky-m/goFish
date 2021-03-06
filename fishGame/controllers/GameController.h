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
#import "BonusItem.h"
#import "Sprite.h"

@interface GameController : UIViewController {

    IBOutlet UIButton *begin;
    IBOutlet UILabel *score;
    IBOutlet UIButton *menuButton;
    UIImageView *fishCollision;
    UIImageView *bootCollision;
    BOOL beginPressed; 
}
    
@property(nonatomic, strong) UIImageView *beginBtnImage;
    
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) Hook *hookInstance;
@property(nonatomic, strong) Fish *fishInstance;
@property(nonatomic, strong) BonusItem *bonusInstance;
@property(nonatomic, strong) FishingLine *fishingLineInstance;
@property(nonatomic, strong) Sprite *spriteInstance;
@property(nonatomic) int scoreValue;
@property(nonatomic, strong) UIImageView *fish;
@property(nonatomic, strong) UIImageView *bonus;
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
-(void) fishCollisionDetails: (Fish *)objInstance : (int) iteration;
-(void)bonusCollision :(BonusItem *) objInstance :(int)iteration :(NSString *) objectType : (CGRect)objFrame;
-(void)addScore: (int)scorevalue;
-(void)setUpNavigationBar;
-(IBAction)back:(id)sender;
-(void) setNumberOfFish :(int)numberOfFish :(int)numberOfBonus :(int)end;
-(int) getScoreValue;
-(BOOL) beginSelected;
-(void) fishCollision :(Sprite *)objInstance :(int)iteration :(NSString *)objectType :(CGRect)objFrame;


@end
