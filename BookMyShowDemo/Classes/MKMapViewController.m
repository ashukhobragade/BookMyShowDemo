//
//  MKMapViewController.m
//  BookMyShowDemo
//
//  Created by AshU on 9/5/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "MKMapViewController.h"
#import "MyAnnotation.h"

@interface MKMapViewController ()<MKMapViewDelegate>

@end

@implementation MKMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLocationPin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setLocationPin {
    
    
    self.mapView.delegate = self;
    
    MKCoordinateRegion myRegion;
    
    myRegion.center.latitude = [self.searchedModel.searchedModelLat doubleValue];
    
    myRegion.center.longitude = [self.searchedModel.searchedModelLon doubleValue];
    
    
    myRegion.span.latitudeDelta = 0.125;
    
    myRegion.span.longitudeDelta = 0.125;
    
    // move the map to our location
    [self.mapView setRegion:myRegion animated:NO];
    
    //annotation
    MyAnnotation *annot = [[MyAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake( myRegion.center.latitude, myRegion.center.longitude)];
    
    [self.mapView addAnnotation:annot];
    
}


#pragma mark - MKMap View methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    if (annotation == mapView.userLocation)
        return nil;
    
    static NSString *MyPinAnnotationIdentifier = @"Pin";
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:MyPinAnnotationIdentifier];
    
    if (!pinView){
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:MyPinAnnotationIdentifier];
        
        annotationView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return annotationView;
        
    }else{
        
        pinView.image = [UIImage imageNamed:@"pin_map_blue"];
        
        return pinView;
    }
    
    return nil;
}

@end
