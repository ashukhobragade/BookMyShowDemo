//
//  MyAnnotation.m
//  BookMyShowDemo
//
//  Created by AshU on 9/4/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//


#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)paramCoordinates{
    self = [super init];
    if (self) {
        coordinate = paramCoordinates;
    }
    return self;
}

@end
