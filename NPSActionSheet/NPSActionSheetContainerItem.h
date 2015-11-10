//
//  NPSActionSheetContainerItem.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/12/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NPSActionSheetContainerItemType) {
    NPSActionSheetContainerNormalItem,
    NPSActionSheetContainerDestructiveItem
};

@interface NPSActionSheetContainerItem : NSObject

@property (nonatomic, copy)   NSString                          *title;
@property (nonatomic, assign) NPSActionSheetContainerItemType   itemType;
@property (nonatomic, assign) NSInteger                         index;

- (instancetype)initWithTitle:(NSString *)title itemType:(NPSActionSheetContainerItemType)itemType;
@end
