//
//  RequestTableViewCell.h
//  CarPoolPrototype5
//
//  Created by Chirag Gajjar on 5/6/14.
//  Copyright (c) 2014 Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong,nonatomic) NSString *objectLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
