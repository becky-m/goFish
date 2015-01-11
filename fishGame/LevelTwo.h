//
//  LevelTwo.h
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface LevelTwo : GameController {
    
    IBOutlet UIButton *beginLevel;
    IBOutlet UIButton *levelTwobtn;
    IBOutlet UIButton *coverBtn;
    NSTimer *timer;
}

-(IBAction) remove: (UIButton*)selector;

@end
