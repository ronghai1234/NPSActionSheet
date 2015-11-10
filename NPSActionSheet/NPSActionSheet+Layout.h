//
//  NPSActionSheet+Layout.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/13/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheet.h"
@class MASConstraint;

@interface NPSActionSheet (Layout)

@property (nonatomic, strong) MASConstraint *bottomC;
@property (nonatomic, assign, readonly) CGFloat titleViewHeight;
@property (nonatomic, assign, readonly) CGFloat cancelViewHeight;
@property (nonatomic, assign, readonly) CGFloat containerViewHeight;
@property (nonatomic, assign, readonly) CGFloat buttonsHeight;
@property (nonatomic, assign, readonly) CGFloat externTotalHeight;

@end
