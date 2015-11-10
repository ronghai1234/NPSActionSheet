//
//  NPSActionSheet+Animation.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/13/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "NPSActionSheet.h"

@interface NPSActionSheet (Animation)

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end
