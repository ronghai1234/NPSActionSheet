//
//  NPSActionSheetBackground.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/10/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPSActionSheetBackground : UIWindow

- (void)showWithAnimationCompletion:(void (^)(BOOL finished))completion;
- (void)hideWithAnimationCompletion:(void (^)(BOOL finished))completion;

@property (nonatomic, copy) void (^dimTapClickBlock)();
@end
