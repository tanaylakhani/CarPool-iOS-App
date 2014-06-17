//
//  DashBoardViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 3/19/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "DashBoardViewController.h"
#import <Parse/Parse.h>

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // For dashboard view - Added by anoop - Begin
    
    PFUser *user = [PFUser currentUser];
    
    NSLog(@"%@",user);
    
    NSString *first = user[@"first"];
    NSString *last = user[@"last"];
    NSString *aboutme = user[@"aboutme"];
    NSString *phone = user[@"phone"];
    NSString *gender = user[@"gender"];
    NSString *place = user[@"place"];
    NSMutableString *name = [NSString stringWithFormat: @"%@ %@", first, last];
    NSDate *dob = user[@"createdAt"];
    PFFile *userImageFile = user[@"image"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *date = [dateFormatter stringFromDate:dob];
    
    self.nameLabel.text = name;
    self.placeLabel.text = place;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            _profilePic.image = [UIImage imageWithData:imageData];
        }
    }];
    
    // For dashboard view - Added by anoop - End
    
    [[self locationManager] startUpdatingLocation];
	CLLocation *location = self->locationManager.location;
	if (!location) {
		return;
	}
    
	// Configure the new event with information from the location.
	CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    PFObject *userlocation = [PFObject objectWithClassName:@"Userlocations"];
    userlocation[@"UserLocation"] = geoPoint;
    userlocation[@"User"] = user;
    [user setObject: geoPoint forKey: @"location"];
    [user saveInBackground ];
    [userlocation saveInBackground];
}

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		return locationManager;
	}
	
	locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.delegate = self;
	
	return locationManager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)logoutButton:(id)sender {
    [PFUser logOut];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Logout" message:@"Thank you for using CarPool" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WelcomeScreen"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (IBAction)logoutBtn:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
