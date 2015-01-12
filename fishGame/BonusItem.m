//
//  BonusItem.m
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "BonusItem.h"

@implementation BonusItem

-(void)initItem {
    bonusItems = [[NSMutableArray alloc] initWithCapacity:1];
}

-(UIImageView*) addFish :(int)whichFIsh: (int)x: (int) y{
  
        _boot = [super addSpriteImage :x :y :0 :whichFIsh];
   
    [bonusItems addObject:_boot];
    return _boot;
}

//get the frame of the fish for use in the game controller class.
-(UIImageView *)getBonusFrame {
    return _boot;
}

@end
