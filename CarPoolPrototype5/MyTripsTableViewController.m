//
//  MyTripsTableViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/8/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "MyTripsTableViewController.h"
#import "MyTripTableViewCell.h"
#import "MyTripViewController.h"

@interface MyTripsTableViewController ()

@end

@implementation MyTripsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // The className to query on
        self.parseClassName = @"TripDetails";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"from";
        
        // The title for this table in the Navigation Controller.
        //self.title = @"To";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 5;
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithClassName:@"TripDetails"];
    self = [super initWithCoder:aDecoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"TripDetails";
        
        // The key of the PFObject to display in the label of the default cell style
        self.fromObjectArray = @"from";
        self.toObjectArray = @"to";
        self.dateObjectArray = @"date";
        self.descriptionObjectArray = @"comment";
        
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 5;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*_fromObjectArray =@[@"xxxx",
     @"xxxx",
     @"xxxx",
     @"xxxx",
     @"xxxx"];
     _toObjectArray =@[@"yyyyy",
     @"yyyyy",
     @"yyyyy",
     @"yyyyy",
     @"yyyyy"];
     _dateObjectArray =@[@"zzzz",
     @"zzzz",
     @"zzzz",
     @"zzzz",
     @"zzzz"];
     _descriptionObjectArray =@[@"xxqqqqqxx",
     @"xxqqqqqxx",
     @"xxqqqqqxx",
     @"xxqqqqqxx",
     @"xxqqqqqxx"];*/
    
    // [self performSelector:@selector(retrieveFromParse)];
}

/* - (void) retrieveFromParse{
 
 PFQuery *retrieveTrips = [PFQuery queryWithClassName:@"Trips"];
 
 [retrieveTrips findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
 if (!error) {
 tripArray = [[NSArray alloc]initWithArray:objects];
 NSLog(@"%@",tripArray);
 }
 }];
 } */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 // Return the number of rows in the section.
 return _fromObjectArray.count;
 }*/

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
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
    
    [query whereKey:@"date" greaterThanOrEqualTo:[NSDate date]];
    [query whereKey:@"status" notEqualTo:@"Pending"];
    [query whereKey:@"status" notEqualTo:@"Completed"];
    [query orderByAscending:@"date"];

    
    return query;
}


/* - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
 static NSString *CellIdentifier = @"BrowseTripsTableViewCell";
 BrowseTripsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
 if (cell == nil) {
 cell = [[BrowseTripsTableViewCell alloc] init];
 }
 
 NSLog(@"description = %@",[cell description]);
 
 cell.fromLabel.text = [object objectForKey:@"From"];
 cell.toLabel.text = [object objectForKey:@"To"];
 cell.dateLabel.text = [object objectForKey:@"Date"];
 cell.descriptionLabel.text = [object objectForKey:@"Description"];
 
 // Configure the cell...
 
 return cell;
 }
 */


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"MyTripsViewCell";
    
//    NSLog(@"output %@",object);
    
    MyTripTableViewCell *cell = (MyTripTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyTripTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    NSMutableString *tripPlace = [NSString stringWithFormat: @"%@ to %@", [object objectForKey:self.fromObjectArray], [object objectForKey:self.toObjectArray]];
    cell.fromLabel.text = tripPlace;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MyTripDetails"]) {
        
        NSLog(@"Segue Pressed");
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:myIndexPath.row];
        
        MyTripViewController *detailViewController = [segue destinationViewController];
        detailViewController.trip = object;
        
    }
}

@end