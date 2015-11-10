//
//  NPSActionSheetBackground.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/10/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheetBackground.h"
#import "NPSActionSheetConst.h"

@interface NPSActionSheetBackground ()

@property (nonatomic, strong) UIView *coverView;

@end

@implementation NPSActionSheetBackground

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque = NO;
        self.windowLevel = UIWindowLevelAlert;
        [self addSubview:self.coverView];
        [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        UIViewController *tempVC = [[UIViewController alloc] init];
        tempVC.view.alpha = 0;
        self.rootViewController = tempVC;
    }
    return self;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:NPSActionSheet_Background_Alpha];
        [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverVieTapClick)]];
    }
    return _coverView;
}

- (void)coverVieTapClick {
    if (self.dimTapClickBlock) {
        self.dimTapClickBlock();
    }
}

- (void)showWithAnimationCompletion:(void (^)(BOOL finished))completion {
    self.coverView.alpha = 0;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:NPSActionSheet_Aniamtion_Duration animations:^{
        weakSelf.coverView.alpha = 1;
    } completion:completion];
}

- (void)hideWithAnimationCompletion:(void (^)(BOOL finished))completion {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:NPSActionSheet_Aniamtion_Duration animations:^{
        weakSelf.coverView.alpha = 0;
    } completion:completion];
}

@end
