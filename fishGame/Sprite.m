//
//  Sprite.m
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite


-(void) initSprite {
    
    int count = 10;
    _horizontalScreen = 4000;//later thiswill be divided by half to determine which side of the screen to appear on.
    //
    //arrays to hold the individual fish and random associated X values for use in positioning and animating fish.
    //
    _sprites = [[NSMutableArray alloc] initWithCapacity:count];
    _randomXArr = [[NSMutableArray alloc] initWithCapacity:count];
    _spriteType = [[NSMutableArray alloc] initWithCapacity:count];
    _spriteImages = [[NSMutableArray alloc] initWithCapacity:10];
    
    for(int i = 0; i < 10; i++) {
        [_spriteImages addObject:@"fill"];
    }
    
     _images = [[NSMutableArray alloc] initWithCapacity:10];
    
    for(int i = 0; i < 10; i++) {
        [_images addObject:@"fill"];
    }
    //_images = @[@"fish", @"fish2", @"fi sh3"];
    
    _resetRound = FALSE;
}

-(void)changeImagesArray: (NSString *)image :(int)arrayPos {
    
     NSLog(@"CHECK! %@",image);
   
    [_images  replaceObjectAtIndex:arrayPos withObject:image];
    
    NSLog(@"CHECK2! %@",_images[arrayPos]);
    //[_images addObject:image];
}

-(void)setNumberOfSprites: (int) sprites {
    _numberOfSprites = sprites;
}

-(void) setImageValue:(int)imageValue {
    
    if(!imageValue) {
        _imageValue = arc4random() % 2;
    }
    _imageValue = imageValue;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (UIImageView*)addSpriteImage: (int)xPos :(int)yPos :(int)direction :(int)whichFIsh {
    
    _screenRect = [[UIScreen mainScreen] bounds];
    
    _screenWidth = _screenRect.size.width;
    _screenHeight = _screenRect.size.height;
    
    _hookWidth = 50;
    
    CGRect hookImageRect = CGRectMake(xPos,yPos,100,80);
    _sprite = [[UIImageView alloc] initWithFrame:hookImageRect];
    
    NSLog(@"NUMBERNUMBER! %@", _spriteImages[whichFIsh]);
    
    NSString *imageNamed = _spriteImages[whichFIsh];
    
    [_sprite setImage:[UIImage imageNamed:imageNamed]];
    [_spriteType addObject:_spriteImages[whichFIsh]];
    
    
    _sprite.opaque = YES;
    
    //the direction of the fish is applied here, if direction parsed is 1 then the fish is right facing.
    //
    if(direction == 1) {
        UIImage* flippedImage = [UIImage imageWithCGImage:_sprite.image.CGImage
                                                    scale:_sprite.image.scale
                                              orientation:UIImageOrientationUpMirrored];
        _sprite.image = flippedImage;
    }
    
    //add the fish object to the fishes array so that we can distinguish between fish later. Also store individual random X value.
    //
    [_sprites addObject:_sprite];
    [_randomXArr addObject:[NSNumber numberWithInt:_X]];
    
    return _sprite;
    
}

-(void)setSpriteScoreValue:(NSString *)type {
    
    if([type isEqualToString:_images[0]]) {
        _scoreValue = 1;
    }
    else if([type isEqualToString:_images[1]]) {
        _scoreValue = 1;
    }
    else if([type isEqualToString:_images[2]]) {
        _scoreValue = 5;
    }
}

-(int)getScoreValue {
    return _scoreValue;
}

-(void)changeImage: (int)end :(int) iteration{
    
    int total = end + 1;
    
    end = arc4random() % total;
    
    if(_images[end]) {
        _changeFishImage = _images[end];
    }
    else {
        _changeFishImage = _images[end - 1]; //avoid out of bounds issues for larger groups of objects.
    }
    
    NSLog(@"CHECK3! %@",_images[iteration]);
    NSLog(@"CHECK4! %@",_images[end]);
    
    [_spriteImages  replaceObjectAtIndex:iteration withObject:_changeFishImage];
    
    NSLog(@"CHECK5! %@",_spriteImages[iteration]);
    NSLog(@"CHECK6! %@",_spriteImages[end]);
}

-(NSString *)getFishType:(int)iteration {
    
    NSString *fishFacing = _spriteType[iteration];
    return fishFacing;
}

-(void)change:(int)type {
    _imageValue = arc4random() % 2;
}

-(UIImageView*) addSprite :(int)whichSprite{
    
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
        _sprite = [self addSpriteImage:_screenWidth + _X - (_horizontalScreen/4) :_Y : 0 :whichSprite];
    }
    else if(_X < _horizontalScreen/2) {
        _sprite = [self addSpriteImage:0 - _X :_Y :1 :whichSprite];
    }
    
    return _sprite;
}


//We need to tell the controller when the fish has been moved upon collision.
-(BOOL)reset: (int) iteration {
    
    _spriteFrame = _sprites[iteration];
    
    if( _spriteFrame.frame.origin.y >  _screenHeight + 400) {
        _resetRound = TRUE;
    }
    
    return _resetRound;
}

//move the fish into an area for storage later.
-(BOOL)spriteStored: (int) iteration {
    
    _resetRound = FALSE;
    
    _spriteFrame = _sprites[iteration];
    
    if( _spriteFrame.frame.origin.y <  0 - 400) {
        _spriteStore = TRUE;
    }
    
    return _spriteStore;
}

//Has the fish been stored? If so tell the controller this.
-(void) setSpriteStore:(BOOL)spriteStore {
    _spriteStore = spriteStore;
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
    
    _spriteFrame = _sprites[iteration];
    
    CGRect tempSprite = CGRectMake(0, _screenHeight + 500, _spriteFrame.frame.size.width,  _spriteFrame.frame.size.height);
    _spriteFrame.frame = tempSprite;
}

//what to do when we want to store the fish.
-(void)store: (int) iteration {
    
    _spriteFrame = _sprites[iteration];
    
    CGRect tempSprite = CGRectMake(0, 0 - 500, _spriteFrame.frame.size.width,  _spriteFrame.frame.size.height);
    _spriteFrame.frame = tempSprite;
}

//get the frame of the fish for use in the game controller class.
-(UIImageView *)getSpriteFrame: (int) iteration {

        _spriteFrame = _sprites[iteration];

    return _spriteFrame;
}

//fish need to swim!
//
-(void)swim {
    
    //time to sort through the fishes array to get the individual fish.
    //
    for(int i = 0; i < _numberOfSprites; i++) {
        //get the fish.
        //
        _spriteImage = _sprites[i];
        
        //assign the individual fish random X value to global X.
        //
        _X = [(NSNumber *)[_randomXArr objectAtIndex:i] intValue];
        
        //work out with direction the fish is swimming in by calculating the position of the fish. If it is on the left side of the screen swim right and vica versa.
        //
        if(_X > _horizontalScreen/2) {
            //check to see when the fish has left the screen area and then reset the position.
            //
            if (_spriteImage.center.x < 0-_spriteImage.frame.size.width) {
                _spriteImage.center = CGPointMake(_horizontalScreen/4, _spriteImage.center.y);
            }
            //animate the fish.
            //
            _spriteImage.center = CGPointMake(_spriteImage.center.x - 2, _spriteImage.center.y);
        }
        else if(_X < _horizontalScreen/2) {
            //check to see when the fish has left the screen area and then reset the position.
            //
            if (_spriteImage.center.x > _screenWidth + _spriteImage.frame.size.width) {
                
                _spriteImage.center = CGPointMake(-_horizontalScreen/4, _spriteImage.center.y);
            }
            //animate the fish.
            //
            _spriteImage.center = CGPointMake(_spriteImage.center.x + 2, _spriteImage.center.y);
        }
    }
}

@end
