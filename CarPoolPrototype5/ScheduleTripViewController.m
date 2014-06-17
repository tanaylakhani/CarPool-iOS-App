//
//  ScheduleTripViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar  on 4/5/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar . All rights reserved.
//

#import "ScheduleTripViewController.h"
#import <Parse/Parse.h>
#import "ScheduledTripDetailsViewController.h"
#import "AddLocationViewController.h"

PFObject *parseObject;
NSString *setFrom, *setTo, *setDescription, *setSeats ;
NSDate *setDate;
NSString *dateText;

NSString * fromPlaceMap = @"";
NSString * toPlaceMap = @"";

@interface ScheduleTripViewController ()

@end

@implementation ScheduleTripViewController

@synthesize tripDate, fromPlace, toPlace, description, seatLabel, seatSlider, dateField;


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
    if(![self.tripFromPlaceText isEqualToString:@""]){
        if(![self.tripFromPlaceText length] == 0){
            fromPlaceMap = self.tripFromPlaceText;
        }
    }
    if(![self.tripToPlaceText isEqualToString:@""]){
        if(![self.tripToPlaceText length] == 0){
            toPlaceMap = self.tripToPlaceText;
        }
    }
    
    fromPlace.text = fromPlaceMap;
    toPlace.text = toPlaceMap;
    description.text = @"";
    dateField.text = @"";
    seatLabel.text = @"0";
    [seatSlider setValue:0 animated:YES];
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320, 800)];
    
    int slideValue = seatSlider.value;
    seatLabel.text = [[NSString alloc]initWithFormat:@"%d",slideValue];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
    [dateField setInputView:datePicker];
    
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

- (IBAction)submitTrip:(id)sender {
    
    [fromPlace resignFirstResponder];
    [toPlace resignFirstResponder];
    [description resignFirstResponder];
    [dateField resignFirstResponder];
    
    [self validateFrom];
    
}

- (IBAction)seatSliderMoved:(id)sender {
    
    int slideValue = seatSlider.value;
    seatLabel.text = [[NSString alloc]initWithFormat:@"%d",slideValue];
}

- (void)validateFrom{
    
    NSDateFormatter * Dateformats= [[NSDateFormatter alloc] init];
    
    [Dateformats setDateFormat:@"MM-dd-yyyy HH:mm a +zzz"]; //ex @"MM/DD/yyyy hh:mm:ss"
    NSDate *myDate=[Dateformats dateFromString:dateText];
    NSLog(@"date picked %@",myDate);
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    NSComparisonResult result = [today compare:myDate];
    
    NSString *dateinFuture = @"NO";
    
    switch (result)
    {
        case NSOrderedAscending:
            dateinFuture = @"YES";
            NSLog(@"%@ is in future from %@", myDate, today);
            break;
        case NSOrderedDescending:
            NSLog(@"%@ is in past from %@", myDate, today);
            break;
        case NSOrderedSame:
            NSLog(@"%@ is the same as %@", myDate, today);
            break;
        default:
            NSLog(@"erorr dates %@, %@", myDate, today);
            break;
    }
    
    if ([fromPlace.text isEqualToString:@""]||[toPlace.text isEqualToString:@""]||[description.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fill all the fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if(result!=NSOrderedAscending){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check the dates" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else {
        NSLog(@"validateFrom else");
        [self addTrip];
    }
}

- (void)addTrip{

    NSDateFormatter * Dateformats= [[NSDateFormatter alloc] init];
    
    [Dateformats setDateFormat:@"MM-dd-yyyy HH:mm a +zzz"]; //ex @"MM/DD/yyyy hh:mm:ss"
    NSDate *myDate=[Dateformats dateFromString:dateText];
    NSLog(@"date picked %@",myDate);
    
    PFObject *trip = [PFObject objectWithClassName:@"Trips"];

    PFUser *user = [PFUser currentUser];
    
    trip[@"From"] = fromPlace.text;
    trip[@"To"] = toPlace.text;
    trip[@"Date"] = myDate;
    trip[@"User"] = user;
    int value = [seatLabel.text intValue];
    trip[@"Seats"] = @(value);
    trip[@"Description"] = description.text;

    [trip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {
            
            setFrom = fromPlace.text;
            setTo = toPlace.text;
            setDate = myDate;
            setSeats = seatLabel.text;
            setDescription = description.text;
            
            parseObject = [trip objectId];
            NSLog(@"Object id %@",parseObject);
            
            
            PFObject *tripDetails = [PFObject objectWithClassName:@"TripDetails"];
            tripDetails[@"from"] = fromPlace.text;
            tripDetails[@"to"] = toPlace.text;
            tripDetails[@"date"] = myDate;
            tripDetails[@"user"] = user;
            tripDetails[@"comment"] = description.text;
            tripDetails[@"tripid"] = parseObject;
            tripDetails[@"status"] = @"Owner";
            
            [tripDetails saveInBackground];
            
            fromPlace.text = @"";
            toPlace.text = @"";
            description.text = @"";
            dateField.text = @"";
            seatLabel.text = @"0";
            seatSlider.value = 0;
            
            [self performSegueWithIdentifier:@"addTripDetailsSegue" sender:self];
            
        }
        else {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}

- (void) dismissKeyboard{
    
    [fromPlace resignFirstResponder];
    [toPlace resignFirstResponder];
    [description resignFirstResponder];
    [dateField resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"segue identifier, %@",[segue identifier]);
    
    if ([[segue identifier] isEqualToString:@"addTripDetailsSegue"]) {
        
        NSLog(@"Segue Pressed : %@",parseObject);
        
        ScheduledTripDetailsViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.detailsFromPlaceText = setFrom;
        detailViewController.detailsToPlaceText = setTo;
        detailViewController.detailsTripDateText = setDate;
        detailViewController.detailsTripSeatsAvailableText = setSeats;
        detailViewController.detailsTripDescriptionText = setDescription;
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"addStartPoint"]) {
        
        AddLocationViewController *startLocationController = [segue destinationViewController];
        
        startLocationController.incomingsegueidentifier = @"StartPoint";
        
    }
    if ([[segue identifier] isEqualToString:@"addDestinationPoint"]) {
        
        AddLocationViewController *startLocationController = [segue destinationViewController];
        
        startLocationController.incomingsegueidentifier = @"DestinationPoint";
        
    }

}

-(void)updateDateField:(id)sender
{
    if([dateField isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)dateField.inputView;
        NSLog(@"date :: %@",picker.date);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm a +zzz"];
        
        NSDate *date = [picker date];
        
        dateText = [dateFormatter stringFromDate:date];
        NSLog(@"formattedDateString: %@", dateText);
        
        dateField.text = dateText;
        
    }
}

@end
