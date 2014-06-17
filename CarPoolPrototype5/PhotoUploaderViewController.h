//
//  PhotoUploaderViewController.h
//  CarPoolPrototype5
//
//  Created by Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar on 4/10/14.
//  Copyright (c) 2014 Anoop Balakrishnan Rema, Tanay Lakhani & Chirag Gajjar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoUploaderViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imgToUpload;
- (IBAction)selectPhotoPressed:(id)sender;

- (IBAction)sendPressed:(id)sender;
@end
