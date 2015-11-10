//
//  NPSActionSheet+Animation.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/13/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheet+Animation.h"
#import "NPSActionSheet+Layout.h"
#import "NPSActionSheetConst.h"

@implementation NPSActionSheet (Animation)

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    [self.superview layoutIfNeeded];
    __weak typeof(self) weakSelf = self;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        weakSelf.bottomC = make.bottom.equalTo(weakSelf.superview).offset(0);
    }];
    [self animated:animated completion:completion];
}

- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    [self.superview layoutIfNeeded];
    __weak typeof(self) weakSelf = self;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        weakSelf.bottomC = make.bottom.equalTo(weakSelf.superview).offset(weakSelf.externTotalHeight);
    }];
    [self animated:animated completion:completion];
}

- (void)animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    if (animated) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:NPSActionSheet_Aniamtion_Duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [weakSelf.superview layoutIfNeeded];
                         } completion:completion];
    } else {
        if (completion) {
            completion(YES);
        }
    }
}

@end
