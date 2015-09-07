//
//  MKMapViewController.h
//  BookMyShowDemo
//
//  Created by AshU on 9/5/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SearchedModel.h"

@interface MKMapViewController : UIViewController

@property(weak,nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong) SearchedModel *searchedModel;

@end
