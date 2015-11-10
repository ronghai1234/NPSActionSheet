//
//  NPSActionSheetManager.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/12/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NPSActionSheet;

@interface NPSActionSheetManager : NSObject

+ (instancetype)sharedManager;

- (void)addActionSheet:(NPSActionSheet *)actionSheet;
- (void)clickActionSheet:(NPSActionSheet *)actionSheet buttonIndex:(NSInteger)buttonIndex;

@end
