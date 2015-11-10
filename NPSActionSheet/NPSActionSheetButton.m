//
//  NPSActionSheetButton.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/14/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheetButton.h"
#import "NPSActionSheetConst.h"
#import "UIImage+Color.h"

@implementation NPSActionSheetButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = NPSActionSheet_TitleFont;
        [self setTitleColor:NPSActionSheet_Button_TitleColor forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:NPSActionSheet_Background_Color] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:NPSActionSheet_DividedLine_Color] forState:UIControlStateHighlighted];
    }
    return self;
}

@end
