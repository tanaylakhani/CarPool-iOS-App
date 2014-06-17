//
//  MainMenuViewController.m
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 3/23/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *) segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath{
    
    NSString *identifier;
    switch (indexPath.row) {
        case 1:
            identifier = @"ProfileSegue";
            break;
        case 2:
            identifier = @"TripsSegue";
            break;
        case 3:
            identifier = @"ScheduleSegue";
            break;
        case 4:
            identifier = @"BrowseSegue";
            break;
        default:
            identifier = @"ProfileSegue";
            break;
    }
    
    return identifier;
}

-(void)configureLeftMenuButton:(UIButton *)button{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
}

@end
