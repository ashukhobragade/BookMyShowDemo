//
//  NearByPlacesTableViewController.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "NearByPlacesTableViewController.h"
#import "AppDelegate.h"
#import "NetworkUtility.h"
#import "Prefs.h"
#import "searchedModel.h"
#import "NearBySearchTableViewCell.h"
#import "DetailViewController.h"
@interface NearByPlacesTableViewController (){
    
    AppDelegate *appDelegate;
    
}
@property (nonatomic, strong) NSMutableArray *searchArray;

@end

@implementation NearByPlacesTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationItem.title = self.title;
    
    _searchArray = [[NSMutableArray alloc] init];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self callApi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NearBySearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearByCellIdentifier" forIndexPath:indexPath];
    
    SearchedModel *searchedModel =[self.searchArray objectAtIndex:indexPath.row];
    
    NSData *imageData = [NSData dataWithContentsOfFile:[self documentsPathForFileName:[[searchedModel.searchedModelImageUrl componentsSeparatedByString:@"/"] lastObject]]];
    
    if (imageData == nil ) {
        
        NSURL *imageURL = [NSURL URLWithString:searchedModel.searchedModelImageUrl];
        
       imageData = [NSData dataWithContentsOfURL:imageURL];
        
        if (imageData) {
            
            cell.cellImageView.image = [UIImage imageWithData:imageData];
            
            NSString *filePath = [self documentsPathForFileName:[[searchedModel.searchedModelImageUrl componentsSeparatedByString:@"/"] lastObject]];
            
            [imageData writeToFile:filePath atomically:YES];
            
        }
    } else {
        
        cell.cellImageView.image = [UIImage imageWithData:imageData];
    }
    
    
    [cell.cellTitle setText:searchedModel.searchedModelName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - Api call

- (void)callApi {
    
    [appDelegate.globalManager showLoader];
    
    NSDictionary *dictionary = @{@"api": @"8080"};
    
    NetworkUtility *networkUtility = [[NetworkUtility alloc] init];
    
    [networkUtility setNetworkUtilitydelegate:(id)self];
    
    NSLog(@"lat =%f,lon =%f",appDelegate.mylocation.coordinate.latitude,appDelegate.mylocation.coordinate.longitude);
    
    [networkUtility requestUrl:[NSString stringWithFormat:kRequestUrl,appDelegate.mylocation.coordinate.latitude,appDelegate.mylocation.coordinate.longitude,[[[NSUserDefaults standardUserDefaults] valueForKey:@"Range"] integerValue],[self.title lowercaseString] ] withParam:dictionary withPath:nil andRequestName:kRequestUrl andPhotoReference:nil];
}

#pragma mark - Network Utility Delegate

- (void)sendSuccessMessage:(NSString *)successMessage withReponseData:(NSDictionary *)responseDict {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [appDelegate.globalManager hideLoader];
        
        NSString *statusMessage = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"status"]];
        
        if ([statusMessage isEqualToString:@"OK"]) {
            
            self.searchArray = [SearchedModel getSearchedModelArray:responseDict ];
            
            [self.tableView reloadData];
            
        }else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Record not found."
                                                           delegate:self cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",nil];
            
            [alert show];
        }
    });
}

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = nil;
    
    indexPath = [self.tableView indexPathForSelectedRow];
    
    DetailViewController *detailViewController = [segue destinationViewController];
    
    [detailViewController setSearchedModel:[self.searchArray objectAtIndex:indexPath.row]];
}

@end
