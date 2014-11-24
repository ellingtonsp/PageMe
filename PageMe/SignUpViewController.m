//
//  BCSignUpViewController.m
//  ribbit
//
//  Created by Brian Chou on 11/15/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signup:(id)sender {
    
    // remove whitespace from text fields then store in NSString
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *verifypassword = [self.verifypasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    /*
     check all user inputfields and show appropriate error message
     */
    
    if ([username length] == 0 || [password length] == 0 || [verifypassword length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                      message:@"Make sure you fill in all fields"
                                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if(![password isEqualToString:verifypassword]){
        UIAlertView *verifypasswordalertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                                    message:@"your password doesnt match its verified"
                                                                    delegate:nil cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil];
        [verifypasswordalertView show];
    }

    else {
        
        // Create PFUser after verifying user inputs
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        
        // send new user information to PARSE and check for any errors
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [self clearAllTextFields];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}
- (void)clearAllTextFields{
        self.usernameField.text = @"";
        self.passwordField.text = @"";
        self.verifypasswordField.text = @"";
        self.emailField.text = @"";
}

@end
