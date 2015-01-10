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
    
    UIImageView *beginBtnImage;
    
    NSTimer *timer;
    Hook *hookInstance;
    Fish *fishInstance;
    FishingLine *fishingLineInstance;
    MenuBar *menuInstance;
    
    IBOutlet UIButton *menuButton;
    
    int scoreValue;
    UIImageView *fish;
    UIImageView *hook;
    NSMutableArray *fishArray;
    CGRect hookFrame;
    CGRect fishFrame;
    CGRect lineFrame;
    BOOL reset; 
    int whichFish; 
    bool hasCollided;
    
    bool userTap; 
}

-(IBAction)StartButton:(id)sender;
-(void)sceneMovement;
-(void)tapRecognition;
-(void)Collision;
-(void)addScore; 

@end
