//
//  DashboardTripsTableViewCell.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 5/5/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardTripsTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *placeLabel;
@property (strong,nonatomic) IBOutlet UILabel *dateLabel;
@property (strong,nonatomic) IBOutlet UILabel *descriptionLabel;

@end
