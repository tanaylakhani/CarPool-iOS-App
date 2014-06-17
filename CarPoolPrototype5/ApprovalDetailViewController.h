//
//  ApprovalDetailViewController.h
//  CarPoolPrototype5
//
//  Created by Chirag Gajjar on 5/6/14.
//  Copyright (c) 2014 Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ApprovalsTableViewCell.h"



@interface ApprovalDetailViewController : PFQueryTableViewController


@property (nonatomic, strong) NSArray *fromObjectArray;
@property (nonatomic, strong) NSArray *toObjectArray;
@property (nonatomic, strong) NSArray *dateObjectArray;
@property (nonatomic, strong) NSArray *descriptionObjectArray;
@property (nonatomic, strong) NSArray *ObjectArray;

@property (strong, nonatomic) NSString *objectLabel;
@property (weak, nonatomic) PFObject *trip;

@end
