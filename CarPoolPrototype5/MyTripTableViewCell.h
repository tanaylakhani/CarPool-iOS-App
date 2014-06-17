//
//  MyTripTableViewCell.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/8/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTripTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *fromLabel;
@property (strong,nonatomic) IBOutlet UILabel *toLabel;
@property (strong,nonatomic) IBOutlet UILabel *dateLabel;
@property (strong,nonatomic) IBOutlet UILabel *descriptionLabel;

@end
