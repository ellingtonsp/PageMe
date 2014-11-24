//
//  InboxViewController.m
//  ribbit
//
//  Created by Brian Chou on 11/14/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import "InboxViewController.h"
#import "ImageViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize video player just one time.
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"found a current user");
        NSLog(@"Current user: %@", currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Query to get messages intended for the Current User
    
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
    
    // Order by descending creation date/time
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            //We found messages!
            self.messages = objects;
            [self.tableView reloadData];
            //            NSLog(@"Retrieved %lu messages",(unsigned long)[self.messages count]);
        }
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // Return the number of sections.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count]; // Return the number of rows in the section.
}

//Populates the cells of the table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Identifies the cells and cycles through them for memory purposes
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Populate cells with messages from Parse, labeled by senderName
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    //Check fileType for icon display
    NSString *fileType = [message objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    return cell;
}

//What happens when a row is selected:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //I think the bad behavior is that it does not determine the image type until the first click?
    
    //access the message so we can later determine if its video or image
    //PFObject *message = [self.messages objectAtIndex:indexPath.row];
    
    //set the selected cell as selectedMessage variable (property)
    self.selectedMessage  = [self.messages objectAtIndex:indexPath.row];
    //check the fileType and save it to fileType variable.
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    
    if ([fileType isEqualToString:@"image"]) {
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else {
        // File type is video
        PFFile *videoFile = [self.selectedMessage objectForKey:@"file"];
        NSURL *fileUrl = [NSURL URLWithString:videoFile.url];
        self.moviePlayer.contentURL = fileUrl;
        [self.moviePlayer prepareToPlay];
        [self.moviePlayer thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        // Add it to view controller so that we can see it
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES]; //must be called after its added.
    }
    
    // Delete an item!
    NSMutableArray *recipientIds = [NSMutableArray arrayWithArray:[self.selectedMessage objectForKey:@"recipientIds"]];
    NSLog(@"Recipients: %@", recipientIds);
    
    if([recipientIds count] == 1) {
        //Last recipient - delete!
        [self.selectedMessage deleteInBackground];
    }
    else{
        //Remove the recipient and save it so others can still view.
        [recipientIds removeObject:[[PFUser currentUser] objectId]];
        [self.selectedMessage setObject:recipientIds forKey:@"recipientIds"];
        [self.selectedMessage saveInBackground];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // This is what happens when certain outlets are triggered from Main.storyboard
    
    //When logout button is clicked
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    //When an image will be shown
    else if ([segue.identifier isEqualToString:@"showImage"]) {
        ImageViewController *imageViewController = (ImageViewController *)segue.destinationViewController;
        imageViewController.message = self.selectedMessage;
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    
}

#pragma mark - Helper Methods

- (IBAction)logout:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [PFUser logOut];
    }
    else {
        
    }
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

@end