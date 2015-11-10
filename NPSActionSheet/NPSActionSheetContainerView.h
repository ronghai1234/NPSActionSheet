//
//  NPSActionContainerView.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/12/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NPSActionSheetButton;

typedef void(^containerViewClickBlock)(NSInteger buttonIndex);

@interface NPSActionSheetContainerView : UIView

@property (nonatomic, strong, readonly) UITableView             *tableView;
@property (nonatomic, copy)             NSArray                 *containerItemArray;
@property (nonatomic, copy)             containerViewClickBlock clickBlock;

@end
