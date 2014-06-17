//
//  RequestTableViewCell.m
//  CarPoolPrototype5
//
//  Created by Chirag Gajjar on 5/6/14.
//  Copyright (c) 2014 Chirag Gajjar. All rights reserved.
//

#import "RequestTableViewCell.h"

@implementation RequestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
