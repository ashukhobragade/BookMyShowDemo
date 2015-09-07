
//  NetworkUtility.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//
#import "NetworkUtility.h"
#import "AppDelegate.h"
#import "Prefs.h"

@implementation NetworkUtility {
      AppDelegate *appDelegate;
}


- (void)requestUrl:(NSString *)requestUrl withParam:(NSDictionary *)paramDict withPath:(NSDictionary *)filePathDict andRequestName:(NSString *)requestName andPhotoReference:(NSString *)photoReference{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",requestUrl]];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSError *error = nil;
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:paramDict
                                                       options:kNilOptions
                                                         error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (response == nil) {
            
             appDelegate = [[UIApplication sharedApplication] delegate];
            
            [appDelegate.globalManager showAlertMessage:@"Network seems to be offline." withTitle:@"Error"];

        }else {
            
            [self sendResponse:response data:data error:error requestName:requestName andPhotoReference:photoReference];
        }
    }];
    
    [postDataTask resume];
        
}

- (void)sendResponse:(NSURLResponse *)response
                data:(NSData *)data
               error:(NSError *)error
         requestName:(NSString *)requestName
andPhotoReference:(NSString *)photoReference{
    
    
    if ([requestName isEqualToString:kImageRequestUrl]) {
    
        [self.networkUtilitydelegate sendSuccessReponseData:data andPhotoReference:photoReference];
        
    } else {
        NSString *string = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"======================\nResponse from Server = %@======================\n",string);
        
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
        
        
        [self.networkUtilitydelegate sendSuccessMessage:nil withReponseData:responseDict];
        
    }
    
}



@end
