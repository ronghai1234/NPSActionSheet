//
//  NPSActionSheet.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/10/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheet.h"
#import "NPSActionSheetConst.h"
#import "NPSActionSheetContainerItem.h"
#import "NPSActionSheetManager.h"
#import "NPSActionSheetTitleView.h"
#import "NPSActionSheetCancelView.h"
#import "NPSActionSheetContainerView.h"
#import "NPSActionSheet+Layout.h"

@interface NPSActionSheet () <NPSActionSheetDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *destructiveButtonTitle;

@property (nonatomic, assign) NSInteger cancelButtonIndex;
@property (nonatomic, assign) NSInteger destructiveButtonIndex;

@property (nonatomic, strong) NPSActionSheetTitleView     *titleView;
@property (nonatomic, strong) NPSActionSheetContainerView *containerView;
@property (nonatomic, strong) NPSActionSheetCancelView    *cancelView;
@property (nonatomic, strong) NSMutableArray              *containerItemArray;
@property (nonatomic, assign) NSInteger                   numberOfButtons;
@property (nonatomic, strong) NSMutableDictionary         *handleBlockDict;
@property (nonatomic, strong) id<NPSActionSheetDelegate>  realDelegate;
@end

@implementation NPSActionSheet

#pragma mark init_method
+ (instancetype)actionSheetWithTitle:(NSString *)title {
    return [[[self class] alloc] initWithTitle:title];
}

- (instancetype)init {
    return [self initWithTitle:nil];
}

- (instancetype)initWithTitle:(NSString *)title {
    return [self initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
}

- (NSInteger)addButtonWithTitle:(NSString *)title handler:(HandlerBlock)block {
    NSInteger index = [self addButtonWithTitle:title];
    [self setHandleBlock:block index:index];
    return index;
}

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<NPSActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        [self addSubviews];
        [self setDestructiveButtonWithTitle:destructiveButtonTitle];
        
        va_list args;
        va_start(args, otherButtonTitles);
        NSMutableArray *otherTitleArray = [[NSMutableArray alloc] initWithObjects:otherButtonTitles, nil];
        id obj;
        while ((obj = va_arg(args, id))) {
            [otherTitleArray addObject:obj];
        }
        va_end(args);
        [otherTitleArray enumerateObjectsUsingBlock:^(NSString *otherTitle, NSUInteger idx, BOOL * stop) {
            [weakSelf addButtonWithTitle:otherTitle];
        }];
        
        self.title = [title copy];
        self.delegate = self;
        self.realDelegate = delegate;
        self.cancelButtonTitle = [cancelButtonTitle copy];
        self.destructiveButtonTitle = [destructiveButtonTitle copy];
        self.numberOfButtons = self.containerItemArray.count + (cancelButtonTitle ? 1 : 0);// 1:cancelBtn
        self.destructiveButtonIndex = destructiveButtonTitle ? 0 : -1;// -1 == null_Index
        self.cancelButtonIndex = cancelButtonTitle ? self.containerItemArray.count : -1;// -1 == null_Index
    }
    return self;
}

- (void)setDestructiveButtonWithTitle:(NSString *)title handler:(HandlerBlock)block {
    NSInteger index = [self setDestructiveButtonWithTitle:title];
    [self setHandleBlock:block index:index];
}

- (void)setCancelButtonWithTitle:(NSString *)title handler:(HandlerBlock)block {
    NSInteger cancelIndex = [self setCancelButtonWithTitle:title];
    [self setHandleBlock:block index:cancelIndex];
}

- (void)setHandleBlock:(HandlerBlock)block index:(NSInteger)index {
    if (block) {
        [self.handleBlockDict setObject:[block copy] forKey:@(index)];
    } else {
        [self.handleBlockDict removeObjectForKey:@(index)];
    }
}

- (NSInteger)addButtonWithTitle:(NSString *)title {
    return [self addButtonWithTitle:title itemType:NPSActionSheetContainerNormalItem];
}

- (NSInteger)setDestructiveButtonWithTitle:(NSString *)title {
    if (!title) return -1;
    if (!self.destructiveButtonTitle) {
        self.destructiveButtonIndex = [self addButtonWithTitle:title itemType:NPSActionSheetContainerDestructiveItem];
    } else {
        NPSActionSheetContainerItem *changedDestructiveItem = [[NPSActionSheetContainerItem alloc] initWithTitle:title itemType:NPSActionSheetContainerDestructiveItem];
        [self.containerItemArray replaceObjectAtIndex:self.destructiveButtonIndex withObject:changedDestructiveItem];
    }
    self.destructiveButtonTitle = title;
    return self.destructiveButtonIndex;
}

- (NSInteger)setCancelButtonWithTitle:(NSString *)title {
    if (!title) return -1;
    if (!self.cancelButtonTitle) {
        self.cancelButtonIndex = self.numberOfButtons;
        self.numberOfButtons++;
    }
    self.cancelButtonTitle = title;
    return self.cancelButtonIndex;
}

- (NSInteger)addButtonWithTitle:(NSString *)title itemType:(NPSActionSheetContainerItemType)itemType {
    NPSActionSheetContainerItem *containerItem = [[NPSActionSheetContainerItem alloc] initWithTitle:title itemType:itemType];
    [self.containerItemArray addObject:containerItem];
    containerItem.index = self.numberOfButtons;
    self.numberOfButtons++;
    return containerItem.index;
}

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self drawSubViews];
        [[NPSActionSheetManager sharedManager] addActionSheet:self];
    });
}

- (void)clickButtonAtIndex:(NSInteger)buttonIndex {
    [[NPSActionSheetManager sharedManager] clickActionSheet:self buttonIndex:buttonIndex];
}

- (void)addSubviews {
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.titleView];
    [self addSubview:self.containerView];
    [self addSubview:self.cancelView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleView.mas_bottom);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
    }];
    [self.cancelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.containerView.mas_bottom);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
}

- (NPSActionSheetTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[NPSActionSheetTitleView alloc] init];
    }
    return _titleView;
}

- (NPSActionSheetCancelView *)cancelView {
    if (!_cancelView) {
        _cancelView = [[NPSActionSheetCancelView alloc] init];
    }
    return _cancelView;
}

- (NPSActionSheetContainerView *)containerView {
    if (!_containerView) {
        _containerView = [[NPSActionSheetContainerView alloc] init];
    }
    return _containerView;
}

- (NSMutableArray *)containerItemArray {
    if (!_containerItemArray) {
        _containerItemArray = [NSMutableArray array];
    }
    return _containerItemArray;
}

- (NSMutableDictionary *)handleBlockDict {
    if (!_handleBlockDict) {
        _handleBlockDict = [NSMutableDictionary dictionary];
    }
    return _handleBlockDict;
}

- (void)drawSubViews {
    self.titleView.title = self.title;
    self.cancelView.cancelButtonTitle = self.cancelButtonTitle;
    self.containerView.containerItemArray = self.containerItemArray;
    [self handleSubViewsClickBlock];
    [self resetContainerLayout];
}

- (void)handleSubViewsClickBlock {
    __weak typeof(self) weakSelf = self;
    self.containerView.clickBlock = ^(NSInteger buttonIndex){
        [weakSelf clickButtonAtIndex:buttonIndex];
    };
    self.cancelView.clickBlock = ^{
        [weakSelf clickButtonAtIndex:weakSelf.cancelButtonIndex];
    };
}

- (void)resetContainerLayout {
    CGFloat otherTitlesHeight = self.buttonsHeight - self.cancelViewHeight;
    __weak typeof(self) weakSelf = self;
    self.containerView.tableView.bounces = (self.containerViewHeight != otherTitlesHeight);
    [self.containerView.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(weakSelf.containerViewHeight));
    }];
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(weakSelf.titleViewHeight));
    }];
}

#pragma mark actionSheetDelegte
- (void)actionSheet:(NPSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    dispatch_block_t block = ^{
        HandlerBlock handleBlock = self.handleBlockDict[@(buttonIndex)];
        if (handleBlock) {
            handleBlock();
        }
        id<NPSActionSheetDelegate> delegate = self.realDelegate;
        if ([delegate respondsToSelector:_cmd]) {
            [delegate actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
        }
    };
    if (NPSActionSheetIsIOS7) {
        [self dispatchAfterTime:NPSActionSheet_Aniamtion_Duration action:block];
    } else {
        block();
    }
}

- (void)willPresentActionSheet:(NPSActionSheet *)actionSheet {
    id<NPSActionSheetDelegate> delegate = self.realDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        [delegate willPresentActionSheet:actionSheet];
    }
}

- (void)didPresentActionSheet:(NPSActionSheet *)actionSheet {
    id<NPSActionSheetDelegate> delegate = self.realDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        [delegate didPresentActionSheet:actionSheet];
    }
}


- (void)actionSheet:(NPSActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    id<NPSActionSheetDelegate> delegate = self.realDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        [delegate actionSheet:actionSheet willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)actionSheet:(NPSActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    id<NPSActionSheetDelegate> delegate = self.realDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        [delegate actionSheet:actionSheet didDismissWithButtonIndex:buttonIndex];
    }
}

//adapt version below iOS8
- (void)dispatchAfterTime:(dispatch_time_t)time action:(dispatch_block_t)action {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), action);
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self);
    self.delegate = nil;
    self.realDelegate = nil;
}

@end
