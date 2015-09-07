//
//  FavoriteTableViewController.m
//  BookMyShowDemo
//
//  Created by AshU on 9/4/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "AppDelegate.h"
#import "SearchedModel.h"
#import "NearBySearchTableViewCell.h"
#import "DetailViewController.h"

@interface FavoriteTableViewController (){

    AppDelegate *appDelegate;
}

@property (nonatomic, strong) NSMutableArray *favoritePlacesArray;

@end

@implementation FavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [appDelegate.globalManager showLoader];
        
        [self getFavouritePlacesFromDB];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.favoritePlacesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearBySearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favoritePlacesIdentifier" forIndexPath:indexPath];
    
    SearchedModel *searchedModel =[self.favoritePlacesArray objectAtIndex:indexPath.row];
    
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
    NSLog(@"name =%@",searchedModel.searchedModelName);
    return cell;
}

- (void) getFavouritePlacesFromDB {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _favoritePlacesArray = [SearchedModel getUserPlaceLists];
        
        [appDelegate.globalManager hideLoader];
        
        [self.tableView reloadData];
    });
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = nil;
    
    indexPath = [self.tableView indexPathForSelectedRow];
    
    DetailViewController *detailViewController = [segue destinationViewController];
    
    [detailViewController setSearchedModel:[self.favoritePlacesArray objectAtIndex:indexPath.row]];
}

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

@end
