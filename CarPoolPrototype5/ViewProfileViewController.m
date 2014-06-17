//
//  ViewProfileViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 5/6/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "ViewProfileViewController.h"
#import <Parse/Parse.h>

@interface ViewProfileViewController ()

@end

@implementation ViewProfileViewController

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
    
    
    PFObject *userid = self.trip[@"User"];
    NSLog(@"userid , %@", userid);

    PFQuery *retrieveStories = [PFQuery queryWithClassName:@"Trips"];
    [retrieveStories whereKey:@"objectId" equalTo:self.trip.objectId];
    [retrieveStories includeKey:@"User"];
    [retrieveStories getObjectInBackgroundWithId:self.trip.objectId block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"trip, %@", gameScore);
        NSLog(@"trip, %@", gameScore[@"User"][@"first"]);
        NSString *first = gameScore[@"User"][@"first"];
        NSString *last = gameScore[@"User"][@"last"];
        NSString *aboutme = gameScore[@"User"][@"aboutme"];
        NSString *phone = gameScore[@"User"][@"phone"];
        NSString *gender = gameScore[@"User"][@"gender"];
        NSString *place = gameScore[@"User"][@"place"];
        NSMutableString *name = [NSString stringWithFormat: @"%@ %@", first, last];
        NSDate *dob = gameScore[@"User"][@"createdAt"];
        PFFile *userImageFile = gameScore[@"User"][@"image"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        
        NSString *date = [dateFormatter stringFromDate:dob];
        
        self.name.text = name;
        self.about.text = aboutme;
        self.place.text = place;
        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
            if (!error) {
                _profilePic.image = [UIImage imageWithData:imageData];
            }
        }];

        PFQuery *retuser = [PFQuery queryWithClassName:@"_User"];
        [retuser whereKey:@"objectId" equalTo:gameScore.objectId];
            [retuser getObjectInBackgroundWithId:gameScore[@"User"] block:^(PFObject *user, NSError *error) {
                NSLog(@"user, %@", user);
            }];
    }];

    
//    NSString *userid = [self.trip valueForKey:@"User"];
//    NSLog(@"%@",userid);
//    
//    PFQuery *teamQuery = [PFQuery queryWithClassName:@"Trips"];
//    [teamQuery whereKey:@"objectId" equalTo:[self.trip ]];
//    
//    PFQuery *userQuery = [PFQuery queryForUser];
//    [userQuery whereKey:@"objectId" matchesKey:@"User" inQuery:teamQuery];
    
    PFUser *user = [PFUser currentUser];
    
//    PFQuery *query = [PFUser query];
    
//    [query getObjectWithId:user];
    
//    NSLog(@"%@",user);
    

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

@end
