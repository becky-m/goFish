//
//  Hook.h
//  fishGame
//
//  Created by Rebecca Mitchell on 07/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Hook : UIImageView {

    
    
}
@property(nonatomic) CGRect screenRect;
@property(nonatomic) CGFloat screenWidth;
@property(nonatomic) CGFloat screenHeight;
@property(nonatomic) int hookWidth;
@property(nonatomic) int hookheight;
@property(nonatomic)UIImageView *hookImageView;
@property(nonatomic) BOOL caughtFish;
@property(nonatomic) BOOL lineDropped;
@property(nonatomic) BOOL gotFish;
@property(nonatomic) BOOL wasTapped;
@property(nonatomic) BOOL reset;

-(void) haulFish: (BOOL)resetFish;
- (UIImageView*)hookImageView;
-(void)moveHookWithLine: (BOOL)userTap;
-(void) moveOnTouch: (int)x;
-(CGRect)getHookFrame;
-(void)changeImageCaught: (int)lineX: (int)lineY : (NSString *)type;
-(void)liftHook;
-(void)dropLine;
-(void) haulFish: (int)lineX: (int)lineY;
-(void)hitBottom;

@end
