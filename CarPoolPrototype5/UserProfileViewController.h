//
//  UserProfileViewController.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 3/20/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController{
    
    IBOutlet UIScrollView *scroll;
}

@property (weak, nonatomic) IBOutlet UIImageView *FBProfilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;

// UITableView row data properties
@property (nonatomic, strong) NSArray *rowTitleArray;
@property (nonatomic, strong) NSMutableArray *rowDataArray;
@property (nonatomic, strong) NSMutableData *imageData;



@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPlace;
@property (weak, nonatomic) IBOutlet UILabel *userAge;
@property (weak, nonatomic) IBOutlet UILabel *userGender;
@property (weak, nonatomic) IBOutlet UITextView *userAboutMe;



@end
