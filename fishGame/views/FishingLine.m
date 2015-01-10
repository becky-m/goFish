//
//  FishingLine.m
//  fishGame
//
//  Created by Rebecca Mitchell on 07/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "FishingLine.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation FishingLine

-(void) initFishingLine {
    //initialise some values for the images and the way they are handled within the view.
    //Clean this up and add some of the set up data to model.
    _screenRect = [[UIScreen mainScreen] bounds];
    
    _screenWidth = _screenRect.size.width;
    _screenHeight = _screenRect.size.height;
    
    _hookWidth = 50;
    _down = YES;
    _lineDropped = FALSE;
    _gotFish = FALSE;
    _reset = FALSE;
    _needsReset = FALSE;
}

//return line frame to help with calculations in game view controller.
-(CGRect) getLineFrame {
    return _lineView.frame;
}

//Make the fishing line, color it. Clean up hard cording and add to model for game settings.
-(UIView *)fishingLine {
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(_screenWidth/2 + _hookWidth/2, 60, 2, 20)];
    _lineView.backgroundColor = RGB(197, 181, 109);
    
    return _lineView;
}

//bring the ship into the 'boat' and reset the values of the view so that we can 'fish' again.
//Reset everything.
-(void) haulFish: (BOOL)resetFish {
        _reset = resetFish;
        _down = YES;
        _lineDropped = FALSE;
        _gotFish = FALSE;
        _reset = FALSE;
        _needsReset = FALSE;
        _reset = FALSE;
}

//Check to see if the data will need to be reset. Clean up and add check data to modal.
-(BOOL) checkIfNeedsReset {
    if(_lineView.frame.size.height < 30) {
        _needsReset = TRUE;
    }
    return _needsReset;
}

//when the user touches the view, an int is parsed into the function and the image will follow your finger.
-(void) moveOnTouch: (int)x {
    if(_lineDropped == FALSE && _gotFish == FALSE) {
        _lineView.center = CGPointMake(x, _lineView.center.y);
    }
}

//set the flag for dropping the line down to NO. The line will travel upward.
-(void)liftLine {
    _down = NO;
}

//drop the line and set the flag to True, therefore the line will be told to go down (grew in height.)

-(void)dropLine {
    _lineDropped = TRUE;
}

//Handle how the line will respond when the hook and line reach the bottom of the view.
//Clean it up.
-(void)hitBottom {
    
    CGRect tempLine = CGRectMake(_lineView.frame.origin.x, _lineView.frame.origin.y, 2, 20);
    _lineView.frame = tempLine;
  
    _down = YES;
    _lineDropped = FALSE;
    _gotFish = FALSE;
    _reset = FALSE;
    _needsReset = FALSE;
    _reset = FALSE;
}

//drop the line when the user taps the view.
-(void) dropLine: (BOOL) userTap {
    
    CGRect frame = _lineView.frame;
    
    if((userTap == true && _down == YES) && (_reset == FALSE)) {
        frame.size.height += 1.0;
    }
    else if((_down == NO)  && (_gotFish == FALSE) && (_reset == FALSE)) {
        frame.size.height -= 1.0;
    }
     _lineView.frame = frame;
}

@end
