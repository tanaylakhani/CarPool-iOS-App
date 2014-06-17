//
//  TripDetailViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema & Tanay Lakhani & Chirag Gajjar on 3/26/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema & Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "TripDetailViewController.h"
#import "ViewProfileViewController.h"
#import "AddLocationViewController.h"
#import "MapViewController.h"


NSString *tripid;

@interface TripDetailViewController ()

@end

@implementation TripDetailViewController

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
    // Do any additional setup after loading the view.
    
    _fromLabel.text = [self.trip objectForKey:@"From"];
    _toLabel.text = [self.trip objectForKey:@"To"];
    _dateLabel.text = [NSString stringWithFormat:@"%@",[self.trip objectForKey:@"Date"]];
    _descriptionLabel.text = [self.trip objectForKey:@"Description"];
    
    _fromText.text = [self.trip objectForKey:@"From"];
    _toText.text = [self.trip objectForKey:@"To"];
    
    tripid = [self.trip objectForKey:@"tripid"];
    NSLog(@"tripid");
    NSLog(tripid);
    
    self.navigationItem.title =  [NSString stringWithFormat:@"%@",[self.trip objectForKey:@"Description"]];

    _objectLabel = [self.trip valueForKey:@"objectId"];
    if(_objectLabel == NULL)
    {
        _objectLabel = self.objectLabel;
        NSLog(_objectLabel);
    }
    else
    {
        NSLog(_objectLabel);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
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

- (IBAction)joinTrip:(id)sender {
    
    
    PFObject *trip = [PFObject objectWithClassName:@"TripDetails"];
    
    PFUser *user = [PFUser currentUser];
    
    trip[@"from"] = self.fromText.text;
    trip[@"to"] = self.toText.text;
    trip[@"comment"] = self.commentText.text;
    trip[@"user"] = user;
    trip[@"status"] = @"Pending";
    trip[@"date"] = [self.trip objectForKey:@"Date"];
    
    _objectLabel = [self.trip valueForKey:@"objectId"];
    
    trip[@"tripid"] = _objectLabel;
    
    [trip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Request send to the trip owner!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            [self performSegueWithIdentifier:@"SendTripRequestSegue" sender:self];
            
        }
        else {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
        
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"ViewUser"]) {
        
        NSLog(@"Segue Pressed view user");
        
        ViewProfileViewController *detailViewController = [segue destinationViewController];
        
        NSLog(@"tripid");
        NSLog(_objectLabel);
        detailViewController.trip = self.trip;
        
    }else if ([[segue identifier] isEqualToString:@"JoinTrip"]) {
        
        NSLog(@"Segue Pressed join trip");
        
        
        TripDetailViewController *tripDetail = [segue destinationViewController];
        
        
        TripDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.trip = self.trip;
        
    }
    
    if ([[segue identifier] isEqualToString:@"addStartPoint"]) {
        
        AddLocationViewController *startLocationController = [segue destinationViewController];
        
        startLocationController.incomingsegueidentifier = @"StartPoint";
        
    }
    if ([[segue identifier] isEqualToString:@"addDestinationPoint"]) {
        
        AddLocationViewController *startLocationController = [segue destinationViewController];
        
        startLocationController.incomingsegueidentifier = @"DestinationPoint";
        
    }
    else if ([[segue identifier] isEqualToString:@"viewRoute"]) {
        
        NSLog(@"Segue Pressed view user");
        
        MapViewController *mapViewController = [segue destinationViewController];
        
        NSLog(@"tripid");
        NSLog(_objectLabel);
        mapViewController.fromlocation = [self.trip objectForKey:@"From"];
        mapViewController.tolocation = [self.trip objectForKey:@"To"];
        mapViewController.tripid = [self.trip valueForKey:@"objectId"];
        //  mapViewController.trip = self.trip;
        
    }

}

- (void) dismissKeyboard{
    
    [self.fromText resignFirstResponder];
    [self.toText resignFirstResponder];
    [self.commentText resignFirstResponder];
    
}

@end
