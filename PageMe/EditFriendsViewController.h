//
//  EditFriendsViewController.h
//  ribbit
//
//  Created by Brian Chou on 11/15/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditFriendsViewController : UITableViewController
@property (strong,nonatomic) NSArray* allUsers;
@property (strong, nonatomic) PFUser* currentUser;
@property (strong, nonatomic) NSMutableArray* friends;

- (BOOL) isFriend: (PFUser *)user;
@end
