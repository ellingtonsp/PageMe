//
//  ImageViewController.h
//  ribbit
//
//  Created by Brian Chou on 11/17/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property (nonatomic,strong) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end