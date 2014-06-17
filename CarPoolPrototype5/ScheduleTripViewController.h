//
//  ScheduleTripViewController.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/5/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTripViewController : UIViewController{
    
    IBOutlet UIScrollView *scroll;
}

@property (strong, nonatomic) IBOutlet UITextField *fromPlace;
@property (strong, nonatomic) IBOutlet UITextField *toPlace;
@property (strong, nonatomic) IBOutlet UIDatePicker *tripDate;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UITextField *dateField;

@property (strong, nonatomic) IBOutlet UISlider *seatSlider;
@property (strong, nonatomic) IBOutlet UILabel *seatLabel;

@property (weak, nonatomic) NSString *tripFromPlaceText;
@property (weak, nonatomic) NSString *tripToPlaceText;


- (IBAction)submitTrip:(id)sender;
- (IBAction)seatSliderMoved:(id)sender;


@end
