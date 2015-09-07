
//  NetworkUtility.h
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol NetworkUtilityDelegate <NSObject>



- (void)sendSuccessMessage:(NSString *)successMessage withReponseData:(NSDictionary *)responseDict;

- (void)sendSuccessReponseData:(NSData *)responseData andPhotoReference:(NSString *)photoReference;

- (void)sendFailureMessage:(NSString *)failureMessage;

@end

@interface NetworkUtility : NSObject <NSURLSessionTaskDelegate,NSURLSessionDelegate>

@property (nonatomic, assign) id<NetworkUtilityDelegate> networkUtilitydelegate;

- (void)requestUrl:(NSString *)requestUrl withParam:(NSDictionary *)paramDict withPath:(NSDictionary *)filePathDict andRequestName:(NSString *)requestName andPhotoReference:(NSString *)photoReference;

@end
