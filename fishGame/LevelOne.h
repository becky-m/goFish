//
//  LevelOne.h
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface LevelOne : GameController {
    IBOutlet UIButton *nextLevel;
    NSTimer *timer; 
}

-(void) loop;

@end
