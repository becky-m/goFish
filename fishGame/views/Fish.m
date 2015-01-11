//
//  Fish.m
//  fishGame
//
//  Created by Rebecca Mitchell on 07/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "Fish.h"

@implementation Fish

-(void) initFish {
    
    int count = 10;
    _horizontalScreen = 4000;//later thiswill be divided by half to determine which side of the screen to appear on.
    //
    //arrays to hold the individual fish and random associated X values for use in positioning and animating fish.
    //
    _fishes = [[NSMutableArray alloc] initWithCapacity:count];
    _randomXArr = [[NSMutableArray alloc] initWithCapacity:count];
    _fishType = [[NSMutableArray alloc] initWithCapacity:count];
    _fishImages = [[NSMutableArray alloc] initWithCapacity:count];
    
    _resetRound = FALSE;
}

-(void)setNumberOfFish: (int) fish {
    _numberOfFish = fish;
}

-(void) setImageValue:(int)imageValue {
    
    if(!imageValue) {
        _imageValue = arc4random() % 2;
    }
    _imageValue = imageValue;

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (UIImageView*)addFishImage: (int) xPos: (int) yPos :(int) direction :(int)whichFIsh {
    
    _screenRect = [[UIScreen mainScreen] bounds];
    
    _screenWidth = _screenRect.size.width;
    _screenHeight = _screenRect.size.height;
    
    _hookWidth = 50;
    
    CGRect hookImageRect = CGRectMake(xPos,yPos,100,80);
    _fish = [[UIImageView alloc] initWithFrame:hookImageRect];

    NSLog(@"NUMBERNUMBER! %@", _fishImages[whichFIsh]);
    
    NSString *imageNamed = _fishImages[whichFIsh];
    
        [_fish setImage:[UIImage imageNamed:imageNamed]];
        [_fishType addObject:_fishImages[whichFIsh]];

    
     _fish.opaque = YES;
    
    //the direction of the fish is applied here, if direction parsed is 1 then the fish is right facing.
    //
    if(direction == 1) {
        UIImage* flippedImage = [UIImage imageWithCGImage:_fish.image.CGImage
                                                    scale:_fish.image.scale
                                              orientation:UIImageOrientationUpMirrored];
        _fish.image = flippedImage;
    }
    
    //add the fish object to the fishes array so that we can distinguish between fish later. Also store individual random X value.
    //
    [_fishes addObject:_fish];
    [_randomXArr addObject:[NSNumber numberWithInt:_X]];
    
    return _fish;

}

-(void)changeImage: (int)type :(int) iteration{
    NSArray *images = @[@"fish", @"fish2", @"fish3"];
    
    int total = type + 1;
    
    type = arc4random() % total;
    
    _changeFishImage = images[type];
    
    [_fishImages addObject:_changeFishImage];
}

-(NSString *)getFishType:(int)iteration {
    
    NSString *fishFacing = _fishType[iteration];
    return fishFacing;
}

-(void)change:(int)type {
     _imageValue = arc4random() % 2;
    
    NSLog(@"NUMBER! %d", _imageValue);
}

-(UIImageView*) addFish :(int)whichFIsh{
    
    //get random X and Y values and then create the fish with these co-ordinate values. Make sure it fits within the bounds of the play area. It needs to be larger on the X axis so that fish will seem to swim off of the screen. Reappearing seamlessly as though other fish.
    //
        _Y = arc4random() % 600;
        _X = arc4random() % _horizontalScreen;
        
        //work out the screen area.
        //
        int topNoSwimArea = 150;
        int btmNoSwimArea = 100;
        
        if(_Y < topNoSwimArea) {
            _Y = _Y + topNoSwimArea;
        }
        else if(_Y > _screenHeight) {
            _Y = _Y - btmNoSwimArea;
        }
        
        //send fish randomly to either side of the screen depending on random Y value.
        //
        if(_X > _horizontalScreen/2) {
            _fish = [self addFishImage:_screenWidth + _X - (_horizontalScreen/4) :_Y : 0 :whichFIsh];
        }
        else if(_X < _horizontalScreen/2) {
            _fish = [self addFishImage:0 - _X :_Y :1 :whichFIsh];
        }
    
    return _fish;
}

-(int) getScore {
    return _fishScore;
}
//We need to tell the controller when the fish has been moved upon collision.
-(BOOL)reset: (int) iteration {
    
    _fishFrame = _fishes[iteration];
    
    if( _fishFrame.frame.origin.y >  _screenHeight + 400) {
        _resetRound = TRUE;
    }
    
    return _resetRound;
}

//move the fish into an area for storage later.
-(BOOL)fishStored: (int) iteration {
    
    _resetRound = FALSE;
    
    _fishFrame = _fishes[iteration];
    
    if( _fishFrame.frame.origin.y <  0 - 400) {
        _fishStore = TRUE;
    }
    
    return _fishStore;
}

//Has the fish been stored? If so tell the controller this.
-(void) setFishStore:(BOOL)fishStore {
    _fishStore = fishStore;
}

//Has the fish been reset? If so tell the controller this.
-(void) setResetRound:(BOOL)resetRound {
    _resetRound = resetRound;
}

//Get whether or not the view has been reset.
-(BOOL) getReset {
    return _resetRound;
}

//What to do when the fish has been caught. Which fish have we caught?
-(void)caught: (int) iteration {
    
    _fishFrame = _fishes[iteration];
    
    CGRect tempFish = CGRectMake(0, _screenHeight + 500, _fishFrame.frame.size.width,  _fishFrame.frame.size.height);
    _fishFrame.frame = tempFish;
}

//what to do when we want to store the fish.
-(void)store: (int) iteration {
    
    _fishFrame = _fishes[iteration];
    
    CGRect tempFish = CGRectMake(0, 0 - 500, _fishFrame.frame.size.width,  _fishFrame.frame.size.height);
    _fishFrame.frame = tempFish;
}

//get the frame of the fish for use in the game controller class.
-(UIImageView *)getFishFrame: (int) iteration {
    
    _fishFrame = _fishes[iteration];
    
    return _fishFrame;
}

//fish need to swim!
//
-(void)swim {
    
    //time to sort through the fishes array to get the individual fish.
    //
    for(int i = 0; i < _numberOfFish; i++) {
        //get the fish.
        //
        _fishImage = _fishes[i];
        
        //assign the individual fish random X value to global X.
        //
        _X = [(NSNumber *)[_randomXArr objectAtIndex:i] intValue];
        
        //work out with direction the fish is swimming in by calculating the position of the fish. If it is on the left side of the screen swim right and vica versa.
        //
        if(_X > _horizontalScreen/2) {
            //check to see when the fish has left the screen area and then reset the position.
            //
            if (_fishImage.center.x < 0-_fishImage.frame.size.width) {
                _fishImage.center = CGPointMake(_horizontalScreen/4, _fishImage.center.y);
            }
            //animate the fish.
            //
            _fishImage.center = CGPointMake(_fishImage.center.x - 2, _fishImage.center.y);
        }
        else if(_X < _horizontalScreen/2) {
            //check to see when the fish has left the screen area and then reset the position.
            //
            if (_fishImage.center.x > _screenWidth + _fishImage.frame.size.width) {
                
                _fishImage.center = CGPointMake(-_horizontalScreen/4, _fishImage.center.y);
            }
            //animate the fish.
            //
            _fishImage.center = CGPointMake(_fishImage.center.x + 2, _fishImage.center.y);
        }
    }
}





@end
