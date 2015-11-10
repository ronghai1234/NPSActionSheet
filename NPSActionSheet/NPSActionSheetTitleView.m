//
//  NPSActionSheetTitleView.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/11/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheetTitleView.h"
#import "NPSActionSheetConst.h"

@interface NPSActionSheetTitleView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) MASConstraint *topC;
@property (nonatomic, strong) MASConstraint *bottomC;

@end

@implementation NPSActionSheetTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.backgroundColor = NPSActionSheet_Background_Color;
        self.clipsToBounds = YES;
        UIView *diviedLine = [[UIView alloc] init];
        diviedLine.backgroundColor = NPSActionSheet_DividedLine_Color;
        [self addSubview:diviedLine];
        [diviedLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
            make.height.equalTo(@(NPSActionSheet_DividedLine_Height));
        }];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(NPSActionSheet_Title_Margin);
        make.right.equalTo(weakSelf).offset(-NPSActionSheet_Title_Margin);
    }];
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = NPSActionSheet_TitleColor;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = NPSActionSheet_SmallTitleFont;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (void)setTitle:(NSString *)title {
    self.textLabel.text = title;
    __weak typeof(self) weakSelf = self;
    if (self.topC) {
        [self.topC uninstall];
    }
    if (self.bottomC) {
        [self.bottomC uninstall];
    }
    if (title) {
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            weakSelf.topC = make.top.equalTo(weakSelf).offset(NPSActionSheet_Title_Margin);
            weakSelf.bottomC = make.bottom.equalTo(weakSelf).offset(-NPSActionSheet_Title_Margin);
        }];
    } else {
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            weakSelf.topC = make.top.equalTo(weakSelf);
            weakSelf.bottomC = make.top.equalTo(weakSelf);
        }];
    }
}

@end
