//
//  BCLoginViewController.m
//  ribbit
//
//  Created by Brian Chou on 11/15/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    NSLog(@"segue was loaded");
    // Do any additional setup after loading the view.
}


- (IBAction)login:(id)sender {
        NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /*
         check all user inputfields and show appropriate error message
         */
        
        if ([username length] == 0 || [password length] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                          message:@"Make sure you fill in all fields"
                                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        
        else {
            [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error){
                if (error) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:[error.userInfo objectForKey:@"error"]
                                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                }
                else {
                    [self.navigationController
                     popToRootViewControllerAnimated:YES];
                }
            }];
        }
    
}
@end
