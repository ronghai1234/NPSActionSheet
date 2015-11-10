//
//  NPSActionSheetCancelView.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/11/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelViewClickBlock)();

@interface NPSActionSheetCancelView : UIView

@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) cancelViewClickBlock clickBlock;

@end
