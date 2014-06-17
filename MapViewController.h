//
//  MapViewController.h
//  CarPoolPrototype5
//
//  Created by Tanay Lakhani  on 4/29/14.
//  Copyright (c) 2014 Tanay Lakhani . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView1;
@property (strong, nonatomic) NSString *tripid;
@property (strong, nonatomic) NSString *fromlocation;
@property (strong, nonatomic) NSString *tolocation;
@property (weak, nonatomic) PFObject *trip;

-(IBAction)Directions1:(id)sender;
-(IBAction)Directions:(id)sender;
@end
