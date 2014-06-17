//
//  ScheduledTripDetailsViewController.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/6/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ScheduledTripDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *detailsFromPlace;
@property (weak, nonatomic) IBOutlet UILabel *detailsToPlace;
@property (weak, nonatomic) IBOutlet UILabel *detailsTripDate;
@property (weak, nonatomic) IBOutlet UILabel *detailsTripSeatsAvailable;
@property (weak, nonatomic) IBOutlet UITextView *detailsTripDescription;


@property (weak, nonatomic) NSString *detailsFromPlaceText;
@property (weak, nonatomic) NSString *detailsToPlaceText;
@property (weak, nonatomic) NSDate *detailsTripDateText;
@property (weak, nonatomic) NSString *detailsTripSeatsAvailableText;
@property (weak, nonatomic) NSString *detailsTripDescriptionText;

- (IBAction)addToCelenderButtonPressed:(id)sender;

@property (weak, nonatomic) PFObject *trip;

@end
