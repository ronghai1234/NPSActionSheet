//
//  NPSActionSheet.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/10/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NPSActionSheet, NPSActionSheetButton;

@protocol NPSActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(NPSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)willPresentActionSheet:(NPSActionSheet *)actionSheet;
- (void)didPresentActionSheet:(NPSActionSheet *)actionSheet;
- (void)actionSheet:(NPSActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)actionSheet:(NPSActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

typedef void(^HandlerBlock)();

@interface NPSActionSheet : UIView

@property (nonatomic, weak) id<NPSActionSheetDelegate>  delegate;
@property (nonatomic, copy, readonly)  NSString         *title;
@property (nonatomic, copy, readonly)  NSString         *cancelButtonTitle;
@property (nonatomic, copy, readonly)  NSString         *destructiveButtonTitle;
@property (nonatomic, assign, readonly) NSInteger       numberOfButtons;
@property (nonatomic, assign, readonly) NSInteger       cancelButtonIndex;
@property (nonatomic, assign, readonly) NSInteger       destructiveButtonIndex;

+ (instancetype)actionSheetWithTitle:(NSString *)title;
- (instancetype)init;
- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title
           delegate:(id<NPSActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonWithTitle:(NSString *)title handler:(HandlerBlock)block;
- (void)setDestructiveButtonWithTitle:(NSString *)title handler:(HandlerBlock)block;
- (void)setCancelButtonWithTitle:(NSString *)title handler:(HandlerBlock)block;


- (void)show;

@end
