//
//  DetailViewController.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "DetailViewController.h"
#import "MyAnnotation.h"
#import "NetworkUtility.h"
#import "AppDelegate.h"
#import "Prefs.h"
#import "MKMapViewController.h"

@interface DetailViewController ()<MKMapViewDelegate>{
    
    AppDelegate *appDelegate;
    
}


@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self.navigationItem setTitle:self.searchedModel.searchedModelName];
    
    [self setButtonToRoundUI];
    
    [self setLocationPin];
    
    [self.address setText:[NSString stringWithFormat:@"Address:\n%@",self.searchedModel.searchedModelAddress]];
    
    if (self.searchedModel.open_now) {
        
        [self.openNow setText:@"Open Now"];
        
    } else {
        
        [self.openNow setText:@"Closed Now"];
    }
   
    [self setImagePlaceHolder];
    
    [self.indicator setHidden:YES];
    
    if (self.searchedModel.photoRefrenceArray.count>0) {
        
        [self callApi];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     MKMapViewController *mKMapViewController = [segue destinationViewController];
     
     [mKMapViewController setSearchedModel:self.searchedModel];
 }

#pragma mark - private methods

-(void) setImagePlaceHolder {
    
    __block  NSData *imageData = [NSData dataWithContentsOfFile:[self documentsPathForFileName:[[self.searchedModel.searchedModelImageUrl componentsSeparatedByString:@"/"] lastObject]]];
    
    if (imageData == nil ) {
        
        NSURL *imageURL = [NSURL URLWithString:self.searchedModel.searchedModelImageUrl];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            imageData = [NSData dataWithContentsOfURL:imageURL];
            
            if (imageData) {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    self.detailImageView.image = [UIImage imageWithData:imageData];
                    
                });
                
                NSString *filePath = [self documentsPathForFileName:[[self.searchedModel.searchedModelImageUrl componentsSeparatedByString:@"/"] lastObject]];
                
                [imageData writeToFile:filePath atomically:YES];
            }
        });
    } else {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.detailImageView.image = [UIImage imageWithData:imageData];
                
            });
        });
    }
}


- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

-(void) setButtonToRoundUI{
    
    self.direction.layer.cornerRadius = 15.0f;
    
    self.favorite.layer.cornerRadius = 15.0f;
    
    self.direction.layer.borderColor = [UIColor colorWithRed:79.0/255.0f green:195.0/255.0f blue:212.0/255.0f alpha:1.0f].CGColor;
    self.favorite.layer.borderColor = [UIColor colorWithRed:79.0/255.0f green:195.0/255.0f blue:212.0/255.0f alpha:1.0f].CGColor;
    self.favorite.layer.borderWidth = 1;
    
    self.direction.layer.borderWidth = 1;
    
    if ([SearchedModel isPlacePresentAlreadyWithSearchedModelId:self.searchedModel.searchedModelId])
    {
        [self.favorite setBackgroundColor:[UIColor colorWithRed:79.0/255.0f green:195.0/255.0f blue:212.0/255.0f alpha:1.0f]];
        
        [self.favorite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

-(void)setLocationPin {
    
    self.mapView.userInteractionEnabled = FALSE;
    
    self.mapView.delegate = self;
    
    MKCoordinateRegion myRegion;
    
    myRegion.center.latitude = [self.searchedModel.searchedModelLat doubleValue];
    
    myRegion.center.longitude = [self.searchedModel.searchedModelLon doubleValue];
    
    
    myRegion.span.latitudeDelta = 0.2;
    
    myRegion.span.longitudeDelta = 0.2;
    
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

#pragma mark - Api call

- (void)callApi {
    
    for (NSString *photoRef in self.searchedModel.photoRefrenceArray) {
        
        __block  NSData *imageData = [NSData dataWithContentsOfFile:[self documentsPathForFileName:photoRef]];
        
        if (imageData !=nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.indicator setHidden:YES];
                
                self.detailImageView.image = [UIImage imageWithData:imageData];
                
            });
        }
        else{
            [self.indicator setHidden:NO];
            [self.indicator startAnimating];
            
            NSDictionary *dictionary = @{@"api": @"8080"};
            
            NetworkUtility *networkUtility = [[NetworkUtility alloc] init];
            
            [networkUtility setNetworkUtilitydelegate:(id)self];
            
            [networkUtility requestUrl:[NSString stringWithFormat:kImageRequestUrl,photoRef] withParam:dictionary withPath:nil andRequestName:kImageRequestUrl andPhotoReference:photoRef];
        }
        
    }
}

#pragma mark - Network Utility Delegate

- (void)sendSuccessReponseData:(NSData *)responseData andPhotoReference:(NSString *)photoReference {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [appDelegate.globalManager hideLoader];
        
        if (responseData != nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                 [self.indicator stopAnimating];
                [self.indicator setHidden:YES];
                self.detailImageView.image = [UIImage imageWithData:responseData];
                
                NSString *filePath = [self documentsPathForFileName:photoReference];
                
                [responseData writeToFile:filePath atomically:YES];
            });
            
        }else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Record not found."
                                                           delegate:self cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",nil];
            
            [alert show];
        }
    });
}


#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
  if (alertView.tag == 2000 && buttonIndex ==1){
        
      [SearchedModel deletePlace:self.searchedModel];
      
      [SearchedModel deletePlacePhotoRef:self.searchedModel];
      
      [self.favorite setBackgroundColor:[UIColor whiteColor]];
      
      [self.favorite setTitleColor:[UIColor colorWithRed:79.0/255.0f green:195.0/255.0f blue:212.0/255.0f alpha:1.0f] forState:UIControlStateNormal];
    }
}

-(IBAction)favouriteBtnClicked:(id)sender {
    
    if (![SearchedModel isPlacePresentAlreadyWithSearchedModelId:self.searchedModel.searchedModelId]) {
        
        NSLog(@"place marked Favourite!");
        
        [SearchedModel insertPlaceData:self.searchedModel];
        
         [SearchedModel insertSearchedModelImageData:self.searchedModel];
        
        [self.favorite setBackgroundColor:[UIColor colorWithRed:79.0/255.0f green:195.0/255.0f blue:212.0/255.0f alpha:1.0f]];
        
        [self.favorite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } else {
        
        NSLog(@"store marked Unfavourite!");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BookMyShowDemo"
                                                        message:@"Do you wish to remove this place from favourite list?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Remove", nil];
        alert.tag = 2000;
        
        [alert show];
    }
}

@end
