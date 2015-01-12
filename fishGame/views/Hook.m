//
//  Hook.m
//  fishGame
//
//  Created by Rebecca Mitchell on 07/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "Hook.h"

@implementation Hook


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (UIImageView*)hookImageView {
    
    _screenRect = [[UIScreen mainScreen] bounds];
    
    _screenWidth = _screenRect.size.width;
    _screenHeight = _screenRect.size.height;
    
    _hookWidth = 50;
    _hookheight = 70;
    _lineDropped = FALSE;
    _gotFish = FALSE;
    
    CGRect hookImageRect = CGRectMake(_screenWidth/2,60,_hookWidth,_hookheight);
    _hookImageView = [[UIImageView alloc] initWithFrame:hookImageRect];
    [_hookImageView setImage:[UIImage imageNamed:@"hook"]];
    _hookImageView.opaque = YES;
    
    return _hookImageView;
}

//change the image for the view when the hook collides with the fish view. There are two types of fish.
-(void)changeImageCaught :(int)lineX :(int)lineY :(NSString *)type {
    
    CGRect hookImageRect = CGRectMake(lineX,lineY, 100,140);
    _hookImageView.frame = hookImageRect;
    
    NSString *image = [NSString stringWithFormat:@"%@%@", type, @"caught"];

       [_hookImageView setImage:[UIImage imageNamed:image]];

    
}

//when the fish is on the 'boat' reset all of the data so that we can attempt another catch.
-(void) haulFish :(int)lineX :(int)lineY {
    if( _hookImageView.center.y < 160 && _caughtFish == TRUE) {
        _gotFish = TRUE;
        
        CGRect hookImageRect = CGRectMake(lineX + 20,60,_hookWidth,_hookheight);
        _hookImageView.frame = hookImageRect;
        
        [_hookImageView setImage:[UIImage imageNamed:@"hook"]];
        _lineDropped = FALSE;
        _gotFish = FALSE;
        _caughtFish = FALSE;
        _wasTapped = FALSE;
        _gotFish = FALSE;
    }
}

//bring the hook up the screen.
-(void)liftHook {
    _caughtFish = TRUE;
}

//get and return the hook frame for use in the game controller.
-(CGRect)getHookFrame {
    
    return _hookImageView.frame;
}

//reset the hook values when the fish is caught..
-(void) haulFish: (BOOL)resetFish {
    _reset = resetFish;
    _lineDropped = FALSE;
    _gotFish = FALSE;
    _caughtFish = FALSE;
    _wasTapped = FALSE;
    _gotFish = FALSE;
    _reset = FALSE; 
}

//reset the values when the hook touches the bottom of the view.
-(void)hitBottom {
    
    CGRect tempHook = CGRectMake(_hookImageView.frame.origin.x,60,_hookWidth,_hookheight);
    _hookImageView.frame = tempHook;
    
    _lineDropped = FALSE;
    _gotFish = FALSE;
    _caughtFish = FALSE;
    _wasTapped = FALSE;
    _gotFish = FALSE;
    _reset = FALSE;
}

//keep the hook 'attached' to the fishing line view. So it will move with FishinLine.
-(void)moveHookWithLine: (BOOL)userTap {
    
    _wasTapped = userTap;
    
    if((userTap == true) && (_caughtFish == FALSE) && (_reset == FALSE)){
        _hookImageView.center = CGPointMake(_hookImageView.center.x, _hookImageView.center.y + 1);
    }
    else if((_caughtFish) == TRUE && (_gotFish == FALSE) && (_reset == FALSE)) {
        _hookImageView.center = CGPointMake(_hookImageView.center.x, _hookImageView.center.y - 1);
    }
    
}

//tell the hook when the line is dropping.
-(void)dropLine {
    _lineDropped = TRUE;
}

//move the hook as the screen is touched.
-(void) moveOnTouch: (int)x {
    
    if(_lineDropped == FALSE) {
          _hookImageView.center = CGPointMake(x, _hookImageView.center.y);
    }
}



@end
