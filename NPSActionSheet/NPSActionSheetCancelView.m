//
//  NPSActionSheetCancelView.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/11/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheetCancelView.h"
#import "NPSActionSheetConst.h"
#import "NPSActionSheetButton.h"

@interface NPSActionSheetCancelView ()

@property (nonatomic, strong) MASConstraint        *heightC;
@property (nonatomic, strong) NPSActionSheetButton *cancelButton;

@end

@implementation NPSActionSheetCancelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = NPSActionSheet_CancelButton_Backgrund_Color;
        self.clipsToBounds = YES;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.equalTo(@(NPSActionSheet_Button_Height));
    }];
}

- (NPSActionSheetButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[NPSActionSheetButton alloc] init];
        [_cancelButton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (void)cancelBtnClick {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    if (self.heightC) {
        [self.heightC uninstall];
    }
    __weak typeof(self) weakSelf = self;
    if (cancelButtonTitle) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            weakSelf.heightC = make.height.equalTo(@(NPSActionSheet_CancelButton_Height));
        }];
    } else {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            weakSelf.heightC = make.height.equalTo(@(0));
        }];
    }
}


@end
