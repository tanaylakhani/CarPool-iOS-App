//
//  UserProfileUpdateViewController.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/8/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileUpdateViewController : UIViewController{
    
    IBOutlet UIScrollView *scroll;
}


@property (weak, nonatomic) IBOutlet UITextField *firstNameEditable;
@property (weak, nonatomic) IBOutlet UITextField *lastNameEditable;
@property (weak, nonatomic) IBOutlet UITextView *aboutEditable;
@property (weak, nonatomic) IBOutlet UITextField *genderEditable;
@property (weak, nonatomic) IBOutlet UITextField *dobEditable;
@property (weak, nonatomic) IBOutlet UITextField *locationEditable;

- (IBAction)profileUpdateButtonPressed:(id)sender;


@end
