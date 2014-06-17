//
//  ApprovalDetailView.m
//  CarPoolPrototype5
//
//  Created by Chirag Gajjar on 5/6/14.
//  Copyright (c) 2014 Chirag Gajjar. All rights reserved.
//

#import "ApprovalDetailView.h"

@interface ApprovalDetailView ()

@end

@implementation ApprovalDetailView

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
    
    _fromLabel.text = [self.trip objectForKey:@"from"];
    _toLabel.text = [self.trip objectForKey:@"to"];
    _dateLabel.text = [NSString stringWithFormat:@"%@",[self.trip objectForKey:@"date"]];
    _descriptionLabel.text = [self.trip objectForKey:@"comment"];
    
    
    self.navigationItem.title =  [NSString stringWithFormat:@"%@",[self.trip objectForKey:@"comment"]];
    
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

- (IBAction)decline:(id)sender{
    
    PFQuery *query = [PFQuery queryWithClassName:@"TripDetails"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.trip.objectId block:^(PFObject *trip, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        
        trip[@"status"] = @"Cancelled";
        [trip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:@"Request has been declined" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                [self performSegueWithIdentifier:@"ApprovalSubmit" sender:self];
                
            }else{
                NSString *errorString = [error userInfo][@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }];
    
    
}
- (IBAction)accept:(id)sender{
    PFQuery *query = [PFQuery queryWithClassName:@"TripDetails"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.trip.objectId block:^(PFObject *trip, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
       
        trip[@"status"] = @"Approved";
        [trip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:@"Request has been approved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                [self performSegueWithIdentifier:@"ApprovalSubmit" sender:self];
                
            }else{
                NSString *errorString = [error userInfo][@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

@end