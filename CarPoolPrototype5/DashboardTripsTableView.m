//
//  DashboardTripsTableView.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 5/5/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "DashboardTripsTableView.h"
#import <Parse/Parse.h>
#import "DashboardTripsTableViewCell.h"

@implementation DashboardTripsTableView


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // Using where clause
    // [query whereKey:@"From" equalTo:@"Brooklyn"];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    PFUser *userid = [PFUser currentUser];
    NSLog(@"user : %@",userid.objectId);
    
    [query whereKey:@"user" equalTo:userid];
    [query orderByAscending:@"date"];
    
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"MyTripsViewCell";
    
    //    NSLog(@"output %@",object);
    
    DashboardTripsTableViewCell *cell = (DashboardTripsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DashboardTripsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    NSMutableString *tripPlace = [NSString stringWithFormat: @"%@ to %@", [object objectForKey:self.fromObjectArray], [object objectForKey:self.toObjectArray]];
    cell.placeLabel.text = tripPlace;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",[object objectForKey:self.dateObjectArray]];
    cell.descriptionLabel.text = [object objectForKey:self.descriptionObjectArray];
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[object objectForKey:@"Id"]]);
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
}

@end
