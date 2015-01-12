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
#import "BonusItem.h"
#import "Sprite.h"

@interface GameController ()

@end

@implementation GameController

- (void)viewDidLoad {
    
    _fishInstance = [[Fish alloc] init];
    _bonusInstance = [[BonusItem alloc] init];
    _spriteInstance = [[Sprite alloc]init];
    
  //  [_fishInstance initFIshFish];
    [_fishInstance initSprite];
    [_bonusInstance initSprite];
    [_bonusInstance initItem];
    
    beginPressed = FALSE;
    
    [self setUpNavigationBar];

    _hasCollided =FALSE;
    _userTap = FALSE;

    //Add the fishing line instance to the controller. 
    _fishingLineInstance = [[FishingLine alloc] init];
    [_fishingLineInstance initFishingLine];
    
    [self.view addSubview:[_fishingLineInstance fishingLine]];
    
    //add fish items to the game controller.
    _fishArray = [[NSMutableArray alloc] initWithCapacity:_numberOfFish];

    //Add the hook instance to the game controller.
    _hookInstance = [[Hook alloc] init];
    
    _hook = [_hookInstance hookImageView];
    
    [self.view addSubview:[_hookInstance hookImageView]];
    
    //what to do when the view is tapped.
    [self tapRecognition];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect beginBtn = CGRectMake(0, 10, 180, 50);
    _beginBtnImage = [[UIImageView alloc] initWithFrame:beginBtn];
    [_beginBtnImage setImage:[UIImage imageNamed:@"begin"]];
    
    [begin addSubview:_beginBtnImage];
}



-(BOOL) beginSelected {
    return beginPressed;
}

-(void) setNumberOfFish :(int)numberOfFish :(int)numberOfBonus :(int)end {
    
    [_fishInstance changeImagesArray:@"fish" :0];
    [_fishInstance changeImagesArray:@"fish2" :1];
    //[_fishInstance changeImagesArray:@"fish3" :2];

    [_bonusInstance changeImagesArray:@"boot1" :0];
    
    if(numberOfFish == (int)nil ) {
        _numberOfFish = 10;
    }
    else {
         _numberOfFish = numberOfFish;
    }
    
    for(int i= 0; i < _numberOfFish; i++) {
       // [_fishInstance change:end];
        [_fishInstance changeImage:end :i];
    }
    
    [_fishInstance setNumberOfSprites:_numberOfFish];
    
    for(int i= 0; i < _numberOfFish; i++) {
        
        _fish = [_fishInstance addSprite: i];
        [self.view addSubview:_fish];
        [_fishArray addObject:_fish];
    }

    for(int i = 0; i < numberOfBonus; i++) {
        [_bonusInstance changeImage:end :i];
    }
    
    for(int i = 0; i < numberOfBonus; i++) {
            _bonus = [_bonusInstance addFish: i : 100: 450];
    }
    
    [self.view addSubview:_bonus];
}

-(void)setUpNavigationBar {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 45, 30)];
    
    [button setImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(back:)
       forControlEvents:UIControlEventTouchUpInside];
    
    //Let's add some menu items to the game controller.
    _menuInstance = [[MenuBar alloc]init];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem =item;

    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addScore: (int)scorevalue {
    _scoreValue  += scorevalue;
    score.text = [NSString stringWithFormat: @"%d",_scoreValue];
}



-(int) getScoreValue {
    return _scoreValue;
}

//Deal with the collision detection here. This function is 'still in contruction'.
-(void)fishCollision :(Fish *) objInstance :(int)iteration :(NSString *) objectType : (CGRect)objFrame{
    
    //get the frames.
    _hookFrame = [_hookInstance getHookFrame];
    _lineFrame = [_fishingLineInstance getLineFrame];
    
    //has the hook already collided with something?
    if((_hasCollided == FALSE) && (_userTap == TRUE)){
        
        fishCollision = [objInstance getSpriteFrame: iteration];
        
        _fishFrame = fishCollision.frame;
        
        CGPoint a = _fishFrame.origin;
        CGPoint b = _hookFrame.origin;
        CGFloat distance = sqrt(pow((b.x - a.x),2) + pow((b.y - a.y),2));
        
        //if the hook object intersects with the dimensions of any fish.
        if(distance < (_fishFrame.size.height/2.0 + _hookFrame.size.height/2.0)){
            
            NSLog(@"co-ordinates %f", _fishFrame.origin.x);
            //images are touching.
            _whichFish = iteration;
            
            if([objectType isEqualToString:@"fish"]) {
                [self fishCollisionDetails:(Fish*)objInstance :iteration];
            }
        }
    }
    
    //what to do when the hook doesn't catch anything.
    if (_hookFrame.origin.y + _hookFrame.size.height == 600){
        [_fishingLineInstance hitBottom];
        [_hookInstance hitBottom];
        _userTap = FALSE;
    }
    
    //reset all hook and fish data upon reeling in the fish.
    if([objInstance reset: _whichFish] == TRUE) {
        BOOL check = [_fishingLineInstance checkIfNeedsReset];
        
        if (check == TRUE) {
            [objInstance store:_whichFish];
        }
        if([objInstance spriteStored:_whichFish] == TRUE) {
            [_fishingLineInstance haulFish:TRUE];
            [_hookInstance haulFish:TRUE];
            
        }
        _userTap = FALSE;
    }
}

//Deal with the collision detection here. This function is 'still in contruction'.
-(void)bonusCollision :(BonusItem *) objInstance :(int)iteration :(NSString *) objectType : (CGRect)objFrame{
    //get the frames.
    _hookFrame = [_hookInstance getHookFrame];
    _lineFrame = [_fishingLineInstance getLineFrame];
    
    
    //has the hook already collided with something?
    if((_hasCollided == FALSE) && (_userTap == TRUE)){
        
        bootCollision = [objInstance getBonusFrame];
        CGRect framthing = bootCollision.frame;
        
        NSLog(@"co-ordinates2 %f", framthing.origin.x);
        
        CGPoint a = framthing.origin;
        CGPoint b = _hookFrame.origin;
        CGFloat distance = sqrt(pow((b.x - a.x),2) + pow((b.y - a.y),2));
        
        //if the hook object intersects with the dimensions of any fish.
        if(distance < (framthing.size.height/2.0 + _hookFrame.size.height/2.0)){
            //images are touching.
            _whichFish = iteration;
        }
    }
}

-(void) fishCollisionDetails: (Fish *)objInstance : (int) iteration{
    [objInstance caught:iteration];
    
    //magic!
    NSString *type = [objInstance getFishType:iteration];
    
    [objInstance setSpriteScoreValue:type];
    
    //change to caught image when a fish has been caught.
    [_hookInstance changeImageCaught: _lineFrame.origin.x- 44: _lineFrame.size.height + 60: type];
    [_fishingLineInstance liftLine];//start reeling the fish in.
    [_hookInstance liftHook];
    
    //tell the controller that the hook and fish have collided.
    _hasCollided = TRUE;
    //reset everthing in the fish instance.
   // [objInstance reset:iteration];
    [self addScore: [objInstance getScoreValue]];//add one to the score.
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

    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(sceneMovement) userInfo:nil repeats:YES];
    
}

//what to do when the user taps the screen.
-(IBAction)handleTap:(id)sender {
    _userTap = TRUE;
    _hasCollided = FALSE;
    
    [_fishInstance setResetRound:FALSE];
    [_fishInstance setSpriteStore:FALSE];
    
    [_hookInstance dropLine];
    [_fishingLineInstance dropLine];
}

//Move the hook and the fishing line when we touch the screen.
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event touchesForView:self.view] anyObject];
    CGPoint point = [touch locationInView:self.view];
    [_hookInstance moveOnTouch:point.x];
    [_fishingLineInstance moveOnTouch:point.x];
}

//deal with animation and 'live' calculations here.
-(void)sceneMovement {
    
    //beginPressed = TRUE;
    
    [_fishInstance swim];
    [_fishingLineInstance dropLine:_userTap];
    [_hookInstance moveHookWithLine:_userTap];
    [_hookInstance haulFish:_lineFrame.origin.x- 44: _lineFrame.size.height];
   
    for(int i = 0; i < _numberOfFish; i++) {
        [self fishCollision: _fishInstance: i :@"fish": _fishInstance.frame];
    }
    
    [self bonusCollision: _bonusInstance :0 :@"boot": _bonusInstance.frame];
    
    _reset = [_fishingLineInstance reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
