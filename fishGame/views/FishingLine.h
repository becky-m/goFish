//
//  FishingLine.h
//  fishGame
//
//  Created by Rebecca Mitchell on 07/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FishingLine : UIImageView {
    
}

@property(nonatomic) CGRect screenRect;
@property(nonatomic) CGFloat screenWidth;
@property(nonatomic) CGFloat screenHeight;
@property(nonatomic) int hookWidth;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic) BOOL down;
@property(nonatomic) BOOL lineDropped;
@property(nonatomic) BOOL gotFish;
@property(nonatomic) BOOL wasTapped;
@property(nonatomic) BOOL reset;
@property(nonatomic) BOOL needsReset;

-(UIView *)fishingLine;
-(void) initFishingLine;
-(void) dropLine: (BOOL) userTap;
-(void) moveOnTouch: (int)x;
-(CGRect) getLineFrame;
-(void)liftLine;
-(void)dropLine;
-(void) haulFish: (BOOL)resetFish;
-(BOOL) checkIfNeedsReset;
-(void)hitBottom;


@end
