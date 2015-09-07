//
//  TypesTableViewController.m
//  BookMyShowDemo
//
//  Created by AshU on 9/3/15.
//  Copyright (c) 2015 Ashish Khobragade. All rights reserved.
//

#import "TypesTableViewController.h"
#import "NearByPlacesTableViewController.h"
#import "TypeTableViewCell.h"

@interface TypesTableViewController ()

@property(nonatomic,strong) NSMutableArray *listArray;

@end

@implementation TypesTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"Range"]==nil) {
        [self SetRangeForSearch:nil];
    }
    
    
      self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _listArray = [[NSMutableArray alloc] initWithObjects:@"Food",@"Gym",@"School",@"Hospital",@"Spa",@"Restaurant", nil];
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

    // Return the number of rows in the section.
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.cellTitle setText:[self.listArray objectAtIndex:indexPath.row]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = nil;
    
    indexPath = [self.tableView indexPathForSelectedRow];
    
        NearByPlacesTableViewController *nearByPlacesTableViewController = [segue destinationViewController];
        [nearByPlacesTableViewController setTitle:[self.listArray objectAtIndex:indexPath.row]];
}

-(IBAction)SetRangeForSearch:(id)sender{
    
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"Set Range"
                                                   message:@" Please set range within which you wants to get places.\n(In meters and enter value greater than 100 to get best results.)"
                                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *textField = [alert textFieldAtIndex:0];
    
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [textField becomeFirstResponder];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField *textField = [alertView textFieldAtIndex:0];
    [textField resignFirstResponder];
    NSLog(@"radius =%ld",[textField.text integerValue]);
    if ([textField.text integerValue]>0) {
        
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"Range"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [self SetRangeForSearch:nil];
    }
}

@end
