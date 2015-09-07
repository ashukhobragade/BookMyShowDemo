//
//  Prefs.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.

#import "Prefs.h"
#import "AppDelegate.h"

@implementation Prefs


NSString *const kSuccess = @"Success";
NSString *const kError = @"Error";
NSString *const kWarning = @"Warning";

NSString *const kRequestUrl = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&types=%@&key=AIzaSyASH-28RPl8gBErTR3EAJWT9t7rkOiWy3o";

//NSString *const kRequestUrl = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=18.5072,73.7986195&radius=500&types=%@&key=AIzaSyASH-28RPl8gBErTR3EAJWT9t7rkOiWy3o";

NSString *const kImageRequestUrl = @"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=AIzaSyASH-28RPl8gBErTR3EAJWT9t7rkOiWy3o";





@end
