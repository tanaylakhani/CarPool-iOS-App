//
//  AddLocationViewController.m
//  CarPoolPrototype5
//
//  Created by Tanay Lakhani  on 5/5/14.
//  Copyright (c) 2014 Tanay Lakhani . All rights reserved.
//


#import "NSObject+CancelableBlock.h"
#import "VJGeoAutocomplete.h"
#import "ScheduleTripViewController.h"
#import <UIKit/UIKit.h>
#import "TripDetailViewController.h"


#import "AddLocationViewController.h"

@interface AddLocationViewController ()

@property(strong, nonatomic) NSMutableArray *dataSource;

- (void)autocompleteWithText:(NSString *)text;

@end

@implementation AddLocationViewController

@synthesize dataSource=_dataSource;

- (NSMutableArray *)dataSource {
    if (_dataSource==nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AutocompleteCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.detailTextLabel.text = [[self.dataSource objectAtIndex:indexPath.row] valueForKey:@"subtitle"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [super tableView deselectRowAtIndexPath:indexPath];
    //  NSString *destinationTitle = [[self.dataSource objectAtIndex:indexPath.row] title];
    //  NSLog(@"Pressed Address: %@",destinationTitle);
    NSLog(@"Row Selected = %i",indexPath.row);
    NSString *destinationTitle = [[_dataSource objectAtIndex:indexPath.row] valueForKey:@"title"];
    NSString *destinationSubTitle = [[_dataSource objectAtIndex:indexPath.row] valueForKey:@"subtitle"];
    NSString *geoAddress = [NSString stringWithFormat:@"%@,%@",destinationTitle,destinationSubTitle];
    NSLog(@"Pressed Address: %@",geoAddress);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"geolocation" sender:geoAddress];
    // [self performSegueWithIdentifier:@"AddLocation" sender:tableView];
    
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue identifier, %@",[segue identifier]);
    if ([[segue identifier] isEqualToString:@"geolocation"]) {
        //    UIViewController *candyDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        //   NSLog(@"Segue Pressed :%@",_dataSource);
        
        //  UITableViewCell *cell = (UITableViewCell*)sender;
        // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // NSIndexPath *indexPath = [self.dataSource indexPathForSelectedRow];
        //  NSLog(@"Pressed Address: %@",indexPath);
        
        // NSString *destinationTitle = [[self.dataSource objectAtIndex:indexPath.row] title];
        //  NSLog(@"Pressed Address: %@", sender);
        //      NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        //id destinationTitle = [_dataSource objectForKey:[locationsIndex objectAtIndex:indexPath.row]];
        //   NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        //        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        
        //     NSLog(@"Row Selected = %ld",(long)indexPath.);
        //     NSString *destinationTitle = [value valueforkey nder];
        //NSLog(@"Pressed Address: %@",destinationTitle);
        
        
        //    ScheduleTripViewController *tripViewController = [segue destinationViewController];
        //  tripViewController.tripFromPlaceText = sender;
        
        // [ScheduleTripViewController forwardingTargetForSelector:fromPlace.text :destinationTitle];
        //[ScheduleTripViewController setTitle:destinationTitle];
        
        
        
        if (([self.incomingsegueidentifier  isEqual: @"DestinationPoint"])) {
            NSLog(@"Pressed DestinationPoint Address: %@", sender);
            ScheduleTripViewController *tripViewController = [segue destinationViewController];
            tripViewController.tripToPlaceText = sender;
            
            TripDetailViewController *tripDetailsViewController = [segue destinationViewController];
            tripDetailsViewController.tripToPlaceText = sender;
            
        }
        if (([self.incomingsegueidentifier  isEqual: @"StartPoint"])) {
            NSLog(@"Pressed StartPoint Address: %@", sender);
            ScheduleTripViewController *tripViewController = [segue destinationViewController];
            tripViewController.tripFromPlaceText = sender;
            
            TripDetailViewController *tripDetailsViewController = [segue destinationViewController];
            tripDetailsViewController.tripFromPlaceText = sender;
            
        }
    }
    
}



#pragma mark - Search bar delegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self autocompleteWithText:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    [self autocompleteWithText:searchBar.text];
}

#pragma mark - private methods

- (void)autocompleteWithText:(NSString *)text {
    [self performBlock:^{
        [VJGeoAutocomplete autocomplete:text completion:^(NSArray *predictions, NSError *error) {
            [self.dataSource removeAllObjects];
            for (VJGeoPrediction *prediction in predictions) {
                [self.dataSource addObject:@{@"title" : prediction.titleForTableViewCell,
                                             @"subtitle": prediction.subtitleForTableViewCell}];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        
    } afterDelay:1.0 cancelPreviousRequest:YES];
}

#pragma mark - TableView Delegate




@end
