//  GlobalManager.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//
#import "GlobalManager.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation GlobalManager

#pragma mark - Public Methods

- (void)showLoader {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD showHUDAddedTo:appDelegate.window.rootViewController.view animated:YES];
    
}

- (void)hideLoader {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    [MBProgressHUD hideHUDForView:appDelegate.window.rootViewController.view animated:YES];
    
}


- (void)showAlertMessage:(NSString *)alertMessage
               withTitle:(NSString *)title {
   
    dispatch_async(dispatch_get_main_queue(), ^{
      
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        [appDelegate.globalManager hideLoader];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    });
}

@end
