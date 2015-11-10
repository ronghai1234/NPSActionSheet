//
//  NPSActionSheetManager.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/12/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheetManager.h"
#import "NPSActionSheetBackground.h"
#import "NPSActionSheet.h"
#import "NPSActionSheetConst.h"
#import "NPSActionSheet+Layout.h"
#import "NPSActionSheet+Animation.h"

static const NPSActionSheetBackground *background;

@interface NPSActionSheetManager ()

@property (nonatomic, strong) NSMutableArray *actionSheetQueue;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, strong) NPSActionSheet *currentActionSheet;

@end

@implementation NPSActionSheetManager

+ (instancetype)sharedManager {
    static NPSActionSheetManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NPSActionSheetManager alloc] init];
    });
    return instance;
}

- (void)addActionSheet:(NPSActionSheet *)actionSheet {
    if ([self.actionSheetQueue containsObject:actionSheet])return;
    [self showBackground];
    [self.actionSheetQueue addObject:actionSheet];
    [background addSubview:actionSheet];
    [actionSheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(background).offset(NPSActionSheet_Title_Top);
        make.left.equalTo(background);
        make.right.equalTo(background);
        make.bottom.equalTo(@(actionSheet.externTotalHeight));
    }];
    
    if (self.isShowing) {
        [self.currentActionSheet hideWithAnimated:NO completion:^(BOOL finished) {
            [actionSheet showWithAnimated:YES completion:nil];
        }];
    }
    self.currentActionSheet = actionSheet;
    self.isShowing = YES;
    
    if ([actionSheet.delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
         [actionSheet.delegate willPresentActionSheet:actionSheet];
    }
    [actionSheet showWithAnimated:YES completion:^(BOOL finished) {
        if ([actionSheet.delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
            [actionSheet.delegate didPresentActionSheet:actionSheet];
        }
    }];
}

- (void)showBackground {
    if (!background) {
        background = [[NPSActionSheetBackground alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [background makeKeyAndVisible];
        __weak typeof(self) weakSelf = self;
        background.dimTapClickBlock = ^{
            [weakSelf dimTapClick];
        };
        [background showWithAnimationCompletion:nil];
    }
}

- (void)dimTapClick {
    if (!self.currentActionSheet.cancelButtonTitle) return;
    [self clickActionSheet:self.currentActionSheet buttonIndex:self.currentActionSheet.cancelButtonIndex];
}

- (void)clickActionSheet:(NPSActionSheet *)actionSheet buttonIndex:(NSInteger)buttonIndex {
    if (actionSheet && ![self.actionSheetQueue containsObject:actionSheet]) return;
    __weak typeof(self) weakSelf = self;
    [weakSelf.actionSheetQueue removeObject:weakSelf.currentActionSheet];
    if (self.actionSheetQueue.count == 0) {
        [background hideWithAnimationCompletion:^(BOOL finished) {
            [background removeFromSuperview];
            background = nil;
            weakSelf.isShowing = NO;
        }];
    }
    if ([self.currentActionSheet.delegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
        [self.currentActionSheet.delegate actionSheet:self.currentActionSheet
                           willDismissWithButtonIndex:buttonIndex];
    }
    if ([weakSelf.currentActionSheet.delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
        [weakSelf.currentActionSheet.delegate actionSheet:weakSelf.currentActionSheet didDismissWithButtonIndex:buttonIndex];
    }
    [self.currentActionSheet hideWithAnimated:YES completion:^(BOOL finished) {
        if ([weakSelf.currentActionSheet.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
            [weakSelf.currentActionSheet.delegate actionSheet:weakSelf.currentActionSheet clickedButtonAtIndex:buttonIndex];
        }
        [weakSelf.currentActionSheet removeFromSuperview];
        weakSelf.currentActionSheet = nil;
        if (weakSelf.actionSheetQueue.count > 0) {
            NPSActionSheet *lastActionSheet = [weakSelf.actionSheetQueue lastObject];
            [lastActionSheet showWithAnimated:YES completion:nil];
            weakSelf.currentActionSheet = lastActionSheet;
        }
    }];
}

- (NSMutableArray *)actionSheetQueue {
    if (!_actionSheetQueue) {
        _actionSheetQueue = [NSMutableArray array];
    }
    return _actionSheetQueue;
}

@end
