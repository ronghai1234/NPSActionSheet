//
//  NPSActionSheet+Layout.m
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/13/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheet+Layout.h"
#import <objc/runtime.h>
#import "NPSActionSheetConst.h"

static const void *NPSActionSheetLayoutBottomC  = &NPSActionSheetLayoutBottomC;

@implementation NPSActionSheet (Layout)

- (void)setBottomC:(MASConstraint *)bottomC {
    [self willChangeValueForKey:@"NPSActionSheetLayoutBottomC"];
    objc_setAssociatedObject(self, &NPSActionSheetLayoutBottomC, bottomC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"NPSActionSheetLayoutBottomC"];
}

- (MASConstraint *)bottomC {
    return objc_getAssociatedObject(self, &NPSActionSheetLayoutBottomC);
}

- (CGFloat)titleViewHeight {
    CGFloat maxHeight = NPSMainScreenHeight - NPSActionSheet_Title_Top;//actionSheet最大高度
    if ([self originTotalHeight] <= maxHeight) {
        return [self titleHeight];
    } else if ([self buttonsHeight] > maxHeight - NPSActionSheet_Title_MinHeight) {
        if ([self titleHeight] > NPSActionSheet_Title_MinHeight) {
            return NPSActionSheet_Title_MinHeight;
        } else {
            return [self titleHeight];
        }
    } else {
        return maxHeight - [self buttonsHeight];
    }
    return 0;
}

- (CGFloat)titleHeight {
    CGSize maxSize = CGSizeMake(NPSMainScreenWidth - 2 * NPSActionSheet_Title_Margin, CGFLOAT_MAX);
    CGFloat textHeight = ceil([self.title boundingRectWithSize:maxSize
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes:@{NSFontAttributeName:NPSActionSheet_SmallTitleFont}
                                                       context:nil].size.height);
    if (self.title) {
        textHeight += 2 * NPSActionSheet_Title_Margin;
    }
    return textHeight;
}

- (CGFloat)buttonsHeight {
    return (NPSActionSheet_Button_Height * self.numberOfButtons) + (self.cancelButtonTitle ? NPSActionSheet_CancelButton_Top : 0);
}

- (CGFloat)containerViewHeight {
    return [self totalHeight] - [self titleViewHeight] - [self cancelViewHeight];
}

- (CGFloat)cancelViewHeight {
    return self.cancelButtonTitle ? NPSActionSheet_CancelButton_Height : 0;
}

- (CGFloat)totalHeight {
    return MIN([self originTotalHeight], NPSMainScreenHeight - NPSActionSheet_Title_Top);
}

- (CGFloat)originTotalHeight {
    return [self titleHeight] + [self buttonsHeight];
}

- (CGFloat)externTotalHeight {
    return [self titleViewHeight] + [self containerViewHeight] + [self cancelViewHeight];
}

@end
