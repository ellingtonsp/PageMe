//
//  InboxViewController.h
//  ribbit
//
//  Created by Brian Chou on 11/14/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface InboxViewController : UITableViewController

@property (nonatomic,strong) NSArray *messages;
@property (nonatomic,strong) PFObject *selectedMessage;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

- (IBAction)logout:(id)sender;


@end
