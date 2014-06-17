//
//  ApprovalDetailView.h
//  CarPoolPrototype5
//
//  Created by Chirag Gajjar on 5/6/14.
//  Copyright (c) 2014 Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface ApprovalDetailView : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) PFObject *trip;

@property (strong, nonatomic) NSString *objectLabel;

- (IBAction)accept:(id)sender;
- (IBAction)decline:(id)sender;

@end
