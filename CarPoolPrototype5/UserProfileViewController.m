//
//  UserProfileViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 3/20/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "UserProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

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
    
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320, 800)];
    
    PFUser *user = [PFUser currentUser];
    
    PFQuery *query = [PFUser query];
    
    [query getObjectWithId:user];
    
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
    
    self.userName.text = name;
    self.userAboutMe.text = aboutme;
    self.userAge.text = dob;
    self.userGender.text = gender;
    self.userPlace.text = place;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            _profilePic.image = [UIImage imageWithData:imageData];
        }
    }];
    
}

-(void) viewDidAppear{
    
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320, 800)];
    
    
    // Create request for user's Facebook data
    FBRequest *request = [FBRequest requestForMe];
    
    PFUser *user = [PFUser currentUser];
    
    NSLog(@"%@",user.objectId);
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserDetails"];
    
    [query whereKey:@"username" equalTo:user.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                // _profilePic.image = [UIImage imageWithData:object[@"image"]];
                PFFile *userImageFile = object[@"image"];
                [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        //UIImage *image = [UIImage imageWithData:imageData];
                        _profilePic.image = [UIImage imageWithData:imageData];
                    }
                }];
                NSString *first = object[@"first"];
                NSString *last = object[@"last"];
                NSMutableString *name = [NSString stringWithFormat: @"%@ %@", first, last];
                NSDate *dob = object[@"dob"];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                
                NSString *date = [dateFormatter stringFromDate:dob];
                
                _userName.text = name;
                _userPlace.text = object[@"location"];
                _userAge.text = date;
                _userGender.text = object[@"gender"];
                _userAboutMe.text = object[@"aboutme"];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

-(void) viewWillAppear{
    NSLog(@"viewWillAppear");
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


// Called every time a chunk of the data is received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // All data has been downloaded, now we can set the image in the header image view
    self.FBProfilePictureView.image = [UIImage imageWithData:self.imageData];
    
    // Set the name in the header view label
    if ([[PFUser currentUser] objectForKey:@"profile"][@"name"]) {
        self.nameLabel.text = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"location"]) {
        self.locationLabel.text = [[PFUser currentUser] objectForKey:@"profile"][@"location"];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"gender"]) {
        self.genderLabel.text = [[PFUser currentUser] objectForKey:@"profile"][@"gender"];
    }
    
    // Add a nice corner radius to the image
    self.FBProfilePictureView.layer.cornerRadius = 8.0f;
    self.FBProfilePictureView.layer.masksToBounds = YES;
}





@end
