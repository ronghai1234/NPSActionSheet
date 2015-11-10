//
//  NPSActionSheetContainerItem.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/12/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheetContainerItem.h"

@implementation NPSActionSheetContainerItem

- (instancetype)initWithTitle:(NSString *)title itemType:(NPSActionSheetContainerItemType)itemType {
    if (self = [super init]) {
        self.title = title;
        self.itemType = itemType;
    }
    return self;
}
@end
