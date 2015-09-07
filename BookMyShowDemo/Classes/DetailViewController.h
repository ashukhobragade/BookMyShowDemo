//
//  DetailViewController.h
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchedModel.h"
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController

@property(nonatomic,strong) SearchedModel *searchedModel;

@property(weak,nonatomic) IBOutlet UIImageView *detailImageView;
@property(weak,nonatomic) IBOutlet MKMapView *mapView;
@property(weak,nonatomic) IBOutlet UIButton *direction;
@property(weak,nonatomic) IBOutlet UIButton *favorite;
@property(weak,nonatomic) IBOutlet UILabel *openNow;
@property(weak,nonatomic) IBOutlet UILabel *address;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@end
