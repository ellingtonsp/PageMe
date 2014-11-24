//
//  BCLoginViewController.h
//  ribbit
//
//  Created by Brian Chou on 11/15/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;

@end
