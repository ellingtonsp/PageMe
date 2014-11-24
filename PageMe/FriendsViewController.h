//
//  FriendsViewController.h
//  ribbit
//
//  Created by Brian Chou on 11/16/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface FriendsViewController : UITableViewController
@property(strong, nonatomic) PFRelation *friendsRelation;
@property(strong, nonatomic) NSArray *friends;

@end
