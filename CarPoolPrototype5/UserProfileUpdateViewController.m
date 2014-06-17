//
//  UserProfileUpdateViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/8/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "UserProfileUpdateViewController.h"
#import <Parse/Parse.h>

@interface UserProfileUpdateViewController ()

@end

@implementation UserProfileUpdateViewController

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
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320, 1000)];
    
    PFUser *user = [PFUser currentUser];
    
    PFQuery *query = [PFUser query];
    
    [query getObjectWithId:user];
    
    NSLog(@"%@",user.objectId);
    
    NSString *first = user[@"first"];
    NSString *last = user[@"last"];
    NSString *aboutme = user[@"aboutme"];
    NSString *phone = user[@"phone"];
    NSString *gender = user[@"gender"];
    NSString *place = user[@"place"];
    NSDate *dob = user[@"birthday"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *date = [dateFormatter stringFromDate:dob];
    
    self.firstNameEditable.text = first;
    self.lastNameEditable.text = last;
    self.aboutEditable.text = aboutme;
    self.dobEditable.text = date;
    self.genderEditable.text = gender;
    self.locationEditable.text = place;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissKeyboard{
    
    [_dobEditable resignFirstResponder];
    [_firstNameEditable resignFirstResponder];
    [_lastNameEditable resignFirstResponder];
    [_aboutEditable resignFirstResponder];
    [_genderEditable resignFirstResponder];
    [_locationEditable resignFirstResponder];
}


- (IBAction)profileUpdateButtonPressed:(id)sender {
    
    PFUser *user = [PFUser currentUser];
    if(![_firstNameEditable.text isEqualToString:@""]){
        [user setObject:_firstNameEditable.text forKey:@"first"];
    }
    if(![_lastNameEditable.text isEqualToString:@""]){
        [user setObject:_lastNameEditable.text forKey:@"last"];
    }
    if(![_aboutEditable.text isEqualToString:@""]){
        [user setObject:_aboutEditable.text forKey:@"aboutme"];
    }
    if(![_genderEditable.text isEqualToString:@""]){
        [user setObject:_genderEditable.text forKey:@"gender"];
    }
    if(![_locationEditable.text isEqualToString:@""]){
        [user setObject:_locationEditable.text forKey:@"place"];
    }
    if(![_dobEditable.text isEqualToString:@""]){
        [user setObject:_dobEditable.text forKey:@"birthday"];
    }
    [user saveInBackground];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Profile updated successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [self dismissViewControllerAnimated:YES completion:NULL];
            
        }else{
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}
@end
