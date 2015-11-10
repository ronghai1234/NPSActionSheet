//
//  NPSActionContainerView.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/12/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheetContainerView.h"
#import "NPSActionSheetConst.h"
#import "NPSActionSheetContainerItem.h"
#import "NPSActionSheetButton.h"

@interface NPSActionSheetContainerCell : UITableViewCell

@property (nonatomic, strong) NPSActionSheetContainerItem *containerItem;
@property (nonatomic, strong) NPSActionSheetButton        *containerBtn;

+ (NSString *)identifier;

@end

@implementation NPSActionSheetContainerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = NPSActionSheet_Background_Color;
        __weak typeof(self) weakSelf = self;
        [self.contentView addSubview:self.containerBtn];
        UIView *diviedLine = [[UIView alloc] init];
        diviedLine.backgroundColor = NPSActionSheet_DividedLine_Color;
        [self.contentView addSubview:diviedLine];
        [self.containerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        [diviedLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView);
            make.right.equalTo(weakSelf.contentView);
            make.height.equalTo(@(NPSActionSheet_DividedLine_Height));
        }];
    }
    return self;
}

- (NPSActionSheetButton *)containerBtn {
    if (!_containerBtn) {
        _containerBtn = [[NPSActionSheetButton alloc] init];
    }
    return _containerBtn;
}

- (void)setContainerItem:(NPSActionSheetContainerItem *)containerItem {
    [self.containerBtn setTitle:containerItem.title forState:UIControlStateNormal];
    [self.containerBtn setTitleColor:(containerItem.itemType == NPSActionSheetContainerNormalItem ? NPSActionSheet_Button_TitleColor : NPSActionSheet_DestructiveButton_TitleColor) forState:UIControlStateNormal];
}

+ (NSString *)identifier {
    return NSStringFromClass(self);
}

@end

@interface NPSActionSheetContainerView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NPSActionSheetContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = NPSActionSheet_Background_Color;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[NPSActionSheetContainerCell class] forCellReuseIdentifier:[NPSActionSheetContainerCell identifier]];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NPSActionSheet_Button_Height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.containerItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NPSActionSheetContainerCell *containerCell = [tableView dequeueReusableCellWithIdentifier:[NPSActionSheetContainerCell identifier]];
    NPSActionSheetContainerItem *containerItem = self.containerItemArray[indexPath.row];
    containerCell.containerItem = containerItem;
    containerCell.containerBtn.tag = containerItem.index;
    [containerCell.containerBtn addTarget:self action:@selector(containerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return containerCell;
}

- (void)containerBtnClick:(NPSActionSheetButton *)button {
    if (self.clickBlock) {
        self.clickBlock(button.tag);
    }
}

- (void)setContainerItemArray:(NSArray *)containerItemArray {
    _containerItemArray = containerItemArray;
    [self.tableView reloadData];
}

@end
