//
//  FeedbackViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 5/3/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "FeedbackViewController.h"
#import <Parse/Parse.h>


NSString *tripId;

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
    self.rateView.notSelectedImage = [UIImage imageNamed:@"empty_star.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"half_star.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"full_star.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    tripId = [self.trip objectId];
    
    NSLog(tripId);
    NSLog(@"tripid");

}

- (void)viewDidUnload
{
    [self setRateView:nil];
    [self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    int rate = (int) rating;
    self.statusLabel.text = [NSString stringWithFormat:@"%d", rate];
}- (void)didReceiveMemoryWarning
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

- (IBAction)submitFeedback:(id)sender {
    
    [self dismissKeyboard];
    
    PFQuery *query = [PFQuery queryWithClassName:@"TripDetails"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:tripId block:^(PFObject *trip, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        trip[@"comment"] = self.commentText.text;
        trip[@"rating"] = self.statusLabel.text;
        trip[@"status"] = @"Completed";
        [trip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:@"Thank you for your feedback" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                [self performSegueWithIdentifier:@"FeedbackSubmit" sender:self];
                
            }else{
                NSString *errorString = [error userInfo][@"error"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }];
    
}

- (void) dismissKeyboard{
    
    [self.commentText resignFirstResponder];
}

@end
