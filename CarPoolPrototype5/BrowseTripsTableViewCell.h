//
//  BrowseTripsTableViewCell.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 3/26/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseTripsTableViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *fromLabel;
@property (strong,nonatomic) IBOutlet UILabel *toLabel;
@property (strong,nonatomic) IBOutlet UILabel *dateLabel;
@property (strong,nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong,nonatomic) NSString *objectLabel;


@end
