//
//  NPSActionSheetConst.h
//  NPSActioSheet
//
//  Created by 樊荣海 on 10/11/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#ifndef NPSActionSheetConst_h
#define NPSActionSheetConst_h
#import <Masonry/Masonry.h>

#define NPSMainScreenWidth                          [[UIScreen mainScreen] applicationFrame].size.width
#define NPSMainScreenHeight                         [[UIScreen mainScreen] applicationFrame].size.height
#define NPSActionSheetIsIOS7                        ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

#define NPSActionSheetColor(R, G, B, A)             [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#define NPSActionSheet_TitleColor                   NPSActionSheetColor(148, 148, 148, 1)
#define NPSActionSheet_Button_TitleColor            NPSActionSheetColor(51, 51, 51, 1)
#define NPSActionSheet_Background_Color             NPSActionSheetColor(248, 248, 248, 1)
#define NPSActionSheet_DestructiveButton_TitleColor NPSActionSheetColor(230, 60, 55, 1)
#define NPSActionSheet_DividedLine_Color            NPSActionSheetColor(0xcc, 0xcc, 0xcc, 1)
#define NPSActionSheet_CancelButton_Backgrund_Color NPSActionSheetColor(232, 232, 232, 1)

#define NPSActionSheet_TitleFont                    [UIFont systemFontOfSize:18]
#define NPSActionSheet_SmallTitleFont               [UIFont systemFontOfSize:14]
#define NPSActionSheet_Button_Height                50.0f
#define NPSActionSheet_CancelButton_Top             6.0f
#define NPSActionSheet_CancelButton_Height          (NPSActionSheet_Button_Height + NPSActionSheet_CancelButton_Top)
#define NPSActionSheet_Title_Margin                 20.0f
#define NPSActionSheet_DividedLine_Height           0.5f
#define NPSActionSheet_Title_Top                    30.0f
#define NPSActionSheet_Title_MinHeight              120.0f  //when actionSheet has much actionButton, and the title is long, essure titleView minHeight
#define NPSActionSheet_Aniamtion_Duration           0.25f
#define NPSActionSheet_Background_Alpha             0.5f

#endif /* NPSActionSheetConst_h */
