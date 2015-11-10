//
//  ViewController.m
//  NPSActionSheetExample
//
//  Created by 樊荣海 on 10/27/15.
//  Copyright © 2015 樊荣海. All rights reserved.
//

#import "ViewController.h"
#import "NPSActionSheet.h"


@interface ViewController () <UIActionSheetDelegate, NPSActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showActionSheet:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    // init way
    // NPSActionSheet *sb = [[NPSActionSheet alloc] initWithTitle:@"title"];
    
    // or
    // NPSActionSheet *sb = [[NPSActionSheet actionSheetWithTitle:@"title"];
    
#warning ! the above two way will not call delegate function
    
    // or
    NPSActionSheet *ac = [[NPSActionSheet alloc] initWithTitle:@"title" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"action1", nil];
    
    // reset cancelButtonTitle
    [ac setCancelButtonWithTitle:@"Cancel" handler:^{
        [weakSelf cancel];
    }];
    
    // reset destructiveButtonTitle
    [ac setDestructiveButtonWithTitle:@"Destructive" handler:^{
        [weakSelf destructive];
    }];
    
    // add other actionButton with action block
    [ac addButtonWithTitle:@"action2" handler:^{
        [weakSelf action2];
    }];
    [ac addButtonWithTitle:@"action3" handler:^{
        [weakSelf action3];
    }];
    
    // show
    [ac show];
}

- (void)cancel {
    [self showAlertView:@"cancel"];
}

- (void)destructive {
    [self showAlertView:@"destructive"];
}

- (void)action2 {
    [self showAlertView:@"action2"];
}

- (void)action3 {
    [self showAlertView:@"action3"];
}

- (void)showAlertView:(NSString *)title {
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [a show];
}


- (void)actionSheet:(NPSActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex: %ld", (long)buttonIndex);
}

- (void)actionSheet:(NPSActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"didDismissWithButtonIndex: %ld", (long)buttonIndex);
}

- (void)actionSheet:(NPSActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"willDismissWithButtonIndex: %ld", (long)buttonIndex);
}

- (void)actionSheetCancel:(NPSActionSheet *)actionSheet {
    NSLog(@"actionSheetCancel: %@", actionSheet);
}

- (void)willPresentActionSheet:(NPSActionSheet *)actionSheet {
    NSLog(@"willPresentActionSheet: %@", actionSheet);
}

- (void)didPresentActionSheet:(NPSActionSheet *)actionSheet {
    NSLog(@"didPresentActionSheet: %@", actionSheet);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
