
//  GlobalManager.h
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalManager : NSObject

- (void)showLoader;
- (void)hideLoader;

- (void)showAlertMessage:(NSString *)alertMessage
               withTitle:(NSString *)title;


@end
