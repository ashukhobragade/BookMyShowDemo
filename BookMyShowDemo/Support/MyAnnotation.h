//
//  MyAnnotation.h
//  BookMyShowDemo
//
//  Created by AshU on 9/4/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

@interface MyAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)paramCoordinates;

@end
