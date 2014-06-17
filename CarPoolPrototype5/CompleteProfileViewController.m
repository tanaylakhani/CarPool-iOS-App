//
//  CompleteProfileViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/11/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "CompleteProfileViewController.h"
#import <Parse/Parse.h>

@interface CompleteProfileViewController ()

@end

@implementation CompleteProfileViewController

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

- (IBAction)saveProfileButtonPressed:(id)sender {
    [self validateForm];
}


- (void)validateForm{
    if ([_firstTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fill in your first name!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if ([_lastTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fill in your last name!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if ([_aboutmeTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please give an introduction about yourself!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if ([_placeTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please tell us where you are from!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self updateUserProfile];
    } 
}

- (void)updateUserProfile{

    PFUser *user = [PFUser currentUser];
    if(![_firstTextField.text isEqualToString:@""]){
        [user setObject:_firstTextField.text forKey:@"first"];
    }
    if(![_lastTextField.text isEqualToString:@""]){
        [user setObject:_lastTextField.text forKey:@"last"];
    }
    if(![_aboutmeTextField.text isEqualToString:@""]){
        [user setObject:_aboutmeTextField.text forKey:@"aboutme"];
    }
    if(![_genderTextField.text isEqualToString:@""]){
        [user setObject:_genderTextField.text forKey:@"gender"];
    }
    if(![_placeTextField.text isEqualToString:@""]){
        [user setObject:_placeTextField.text forKey:@"place"];
    }
    if(![_phoneTextField.text isEqualToString:@""]){
        [user setObject:_phoneTextField.text forKey:@"phone"];
    }
    if(![_birthdayTextField.text isEqualToString:@""]){
        [user setObject:_birthdayTextField.text forKey:@"birthday"];
    }
    [user saveInBackground];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            [self performSegueWithIdentifier:@"pickImage" sender:self];
            
        }else{
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}

- (void) dismissKeyboard{
    
    [_firstTextField resignFirstResponder];
    [_lastTextField resignFirstResponder];
    [_aboutmeTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_placeTextField resignFirstResponder];
    [_birthdayTextField resignFirstResponder];
    [_genderTextField resignFirstResponder];
}

@end
