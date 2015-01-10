//
//  Game.m
//  fishGame
//
//  Created by Rebecca Mitchell on 05/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "GameController.h"
#import "Hook.h"
#import "Fish.h"
#import "FishingLine.h"
#import "MenuBar.h"

@interface GameController ()

@end

@implementation GameController

- (void)viewDidLoad {

    hasCollided =FALSE;
    userTap = FALSE;
    
    //Let's add some menu items to the game controller.
    menuInstance = [[MenuBar alloc]init];
    
    [menuButton addSubview:[menuInstance addMenuBar]];

    //Add the fishing line instance to the controller. 
    fishingLineInstance = [[FishingLine alloc] init];
    [fishingLineInstance initFishingLine];
    
    [self.view addSubview:[fishingLineInstance fishingLine]];
    
    //add fish items to the game controller.
    fishArray = [[NSMutableArray alloc] initWithCapacity:10];

    
    fishInstance = [[Fish alloc] init];
    [fishInstance initFish];
    
    for(int i= 0; i < 10; i++) {
        
        fish = [fishInstance addFish];
        
        [self.view addSubview:fish];
        
        [fishArray addObject:fish];
        
    }

    //Add the hook instance to the game controller.
    hookInstance = [[Hook alloc] init];
    
    hook = [hookInstance hookImageView];
    
    [self.view addSubview:[hookInstance hookImageView]];
    
    //what to do when the view is tapped.
    [self tapRecognition];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect beginBtn = CGRectMake(0, 10, 180, 50);
    beginBtnImage = [[UIImageView alloc] initWithFrame:beginBtn];
    [beginBtnImage setImage:[UIImage imageNamed:@"begin"]];
    
    [begin addSubview:beginBtnImage];
}

-(void)addScore {
    scoreValue  += 1;
    score.text = [NSString stringWithFormat: @"%d",scoreValue];
}


//Deal with the collision detection here. This function is 'still in contruction'.
-(void)Collision {
    
    //get the frames.
    hookFrame = [hookInstance getHookFrame];
    lineFrame = [fishingLineInstance getLineFrame];
    
    //has the hook already collided with something?
    if(hasCollided == FALSE){
        
        //work through the obects and find any collisions.
        for(int i = 0; i < 10; i++) {
            
            UIImageView *fish = [fishInstance getFishFrame: i];
        
            fishFrame = fish.frame;
        
            CGPoint a = fishFrame.origin;
            CGPoint b = hookFrame.origin;
            CGFloat distance = sqrt(pow((b.x - a.x),2) + pow((b.y - a.y),2));
        
            //if the hook object intersects with the dimensions of any fish.
            if(distance < (fishFrame.size.height/2.0 + hookFrame.size.height/2.0)){
                //images are touching.
                whichFish = i;
                [fishInstance caught:i];
                
                //magic!
                int type = [[fishInstance getFishType:i]intValue];
                //change to caught image when a fish has been caught.
                [hookInstance changeImageCaught: lineFrame.origin.x- 44: lineFrame.size.height + 60: type];
                [fishingLineInstance liftLine];//start reeling the fish in.
                [hookInstance liftHook];
                
                //tell the controller that the hook and fish have collided.
                hasCollided = TRUE;
                //reset everthing in the fish instance.
                [fishInstance reset:i];
                [self addScore];//add one to the score.
                
            }
            
            //what to do when the hook doesn't catch anything.
            if (hookFrame.origin.y + hookFrame.size.height == 600){
                [fishingLineInstance hitBottom];
                [hookInstance hitBottom];
                userTap = FALSE;
            }
        }
    }
    
    //reset all hook and fish data upon reeling in the fish.
        if([fishInstance reset: whichFish] == TRUE) {
            BOOL check = [fishingLineInstance checkIfNeedsReset];
        
            if (check == TRUE) {
                [fishInstance store:whichFish];
            }
            if([fishInstance fishStored:whichFish] == TRUE) {
                [fishingLineInstance haulFish:TRUE];
                [hookInstance haulFish:TRUE];
                
            }
            userTap = FALSE;
        }
}

-(void)tapRecognition {
    // Attach a tap gesture recogniser to the View. It will be used to recognise user
    // interaction for the fish and hook.
    //
    UITapGestureRecognizer *recogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    recogniser.numberOfTapsRequired = 1;
    recogniser.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:recogniser];
}

//Start button code. Hide the button and set up the timer for animation and logic calculation.
-(IBAction)StartButton:(id)sender {
    
    begin.hidden= YES;

    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(sceneMovement) userInfo:nil repeats:YES];
    
}

//what to do when the user taps the screen.
-(IBAction)handleTap:(id)sender {
    userTap = TRUE;
    hasCollided = FALSE;
    
    [fishInstance setResetRound:FALSE];
    [fishInstance setFishStore:FALSE];
    
    [hookInstance dropLine];
    [fishingLineInstance dropLine];
    
    NSLog(@"CHECK STUFF %f", hookFrame.origin.y);
}

//Move the hook and the fishing line when we touch the screen.
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event touchesForView:self.view] anyObject];
    CGPoint point = [touch locationInView:self.view];
    [hookInstance moveOnTouch:point.x];
    [fishingLineInstance moveOnTouch:point.x];
}

//deal with animation and 'live' calculations here.
-(void)sceneMovement {
    
    [fishInstance swim];
    [fishingLineInstance dropLine:userTap];
    [hookInstance moveHookWithLine:userTap];
    [hookInstance haulFish:lineFrame.origin.x- 44: lineFrame.size.height];
    [self Collision];
    reset = [fishingLineInstance reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
