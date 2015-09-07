//
//  AppDelegate.h
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GlobalManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GlobalManager *globalManager;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocation *mylocation;
@end

