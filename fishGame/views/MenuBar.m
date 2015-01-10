//
//  MenuBar.m
//  fishGame
//
//  Created by Rebecca Mitchell on 09/01/2015.
//  Copyright (c) 2015 Rebecca Mitchell. All rights reserved.
//

#import "MenuBar.h"

@implementation MenuBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIButton *)addMenuBar {
    
    _menuBar = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 45, 30)];
    
    [_menuBar setImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateNormal];
    
    return _menuBar;
}

@end
