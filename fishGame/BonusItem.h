//
//  BonusItem.h
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sprite.h"

@interface BonusItem : Sprite {
    NSMutableArray *bonusItems;
}

@property(nonatomic, strong) UIImageView *boot;


-(UIImageView*) addFish :(int)whichFIsh :(int)x :(int) y;
-(UIImageView *)getBonusFrame;
-(void)initItem;

@end
