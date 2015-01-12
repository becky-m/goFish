//
//  Sprite.h
//  fishGame
//
//  Created by Rebecca Mitchell on 11/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sprite : UIImageView


@property(nonatomic) CGRect screenRect;
@property(nonatomic) CGFloat screenWidth;
@property(nonatomic) CGFloat screenHeight;
@property(nonatomic) int hookWidth;
@property(nonatomic)UIImageView *fishImageView;
@property(nonatomic, strong) NSMutableArray *sprites;
@property(nonatomic, strong) NSMutableArray *randomXArr;
@property(nonatomic, strong) NSMutableArray *spriteType;
@property(nonatomic, strong) UIImageView *sprite;
@property(nonatomic, strong) UIImageView *spriteImage;
@property(nonatomic) int imageValue;
@property(nonatomic) int X;
@property(nonatomic) int Y;
@property(nonatomic) int horizontalScreen;
@property(nonatomic, strong) UIImageView *spriteFrame;
@property(nonatomic) BOOL resetRound;
@property(nonatomic) BOOL spriteStore;
@property(nonatomic) int numberOfSprites;
@property(nonatomic) int fishDirection;
@property(nonatomic, strong) NSMutableArray *spriteImages;
@property(nonatomic, strong) NSString *changeFishImage;
@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic) int scoreValue;

-(BOOL) getReset;
-(BOOL)spriteStored: (int) iteration;
-(UIImageView*) addSprite :(int)whichSprite;
-(void) initSprite;
-(void) swim;
-(UIImageView *)getSpriteFrame: (int) iteration;
-(void)caught: (int) iteration ;
-(NSString *)getFishType:(int)iteration;
-(BOOL)reset: (int) iteration;
-(void)store: (int) iteration;
-(void)setNumberOfSprites: (int) fish;
-(void) setImageValue:(int)imageValue;
-(void) change:(int)type;
-(void)changeImage: (int)end :(int) iteration;
-(void)setSpriteScoreValue:(NSString *)type;
-(int)getScoreValue;
-(void)changeImagesArray: (NSString *)image : (int)arrayPos;
- (UIImageView*)addSpriteImage: (int)xPos :(int)yPos :(int)direction :(int)whichFIsh;

@end
