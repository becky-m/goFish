//
//  Fish.h
//  fishGame
//
//  Created by Rebecca Mitchell on 07/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fish : UIImageView {
    
}

@property(nonatomic) CGRect screenRect;
@property(nonatomic) CGFloat screenWidth;
@property(nonatomic) CGFloat screenHeight;
@property(nonatomic) int hookWidth;
@property(nonatomic)UIImageView *fishImageView;
@property(nonatomic, strong) NSMutableArray *fishes;
@property(nonatomic, strong) NSMutableArray *randomXArr;
@property(nonatomic, strong) NSMutableArray *fishType;
@property(nonatomic, strong) UIImageView *fish;
@property(nonatomic, strong) UIImageView *fishImage;
@property(nonatomic) int imageValue;
@property(nonatomic) int X;
@property(nonatomic) int Y;
@property(nonatomic) int horizontalScreen;
@property(nonatomic, strong) UIImageView *fishFrame;
@property(nonatomic) BOOL resetRound;
@property(nonatomic) BOOL fishStore;
@property(nonatomic) int numberOfFish;
@property(nonatomic) int fishDirection;
@property(nonatomic, strong) NSMutableArray *fishImages;
@property(nonatomic, strong) NSString *changeFishImage;
@property(nonatomic, strong) NSArray *images;
@property(nonatomic) int scoreValue;

-(BOOL) getReset;
-(BOOL)fishStored: (int) iteration;
- (UIImageView*)addFishImage: (int) xPos: (int) yPos :(int) direction :(int)whichFIsh;
-(UIImageView*) addFish :(int)whichFIsh;
-(void) initFish;
-(void) swim;
-(UIImageView *)getFishFrame: (int) iteration;
-(void)caught: (int) iteration ;
-(NSString *)getFishType:(int)iteration;
-(BOOL)reset: (int) iteration;
-(void)store: (int) iteration;
-(void)setNumberOfFish: (int) fish; 
-(void) setImageValue:(int)imageValue;
-(void) change:(int)type;
-(void)changeImage: (int)type :(int) iteration; 
-(void)setFishScoreValue:(NSString *)type; 
-(int)getScoreValue;

@end
