//
//  ImageViewController.m
//  ribbit
//
//  Created by Brian Chou on 11/17/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //download file from Parse
    PFFile *imageFile = [self.message objectForKey:@"file"];
    //Get URL property (NSString)
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent from %@", senderName];
    self.navigationItem.title = title;
}

//Make disappear after 10 seconds
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if([self respondsToSelector:@selector(timeout)]) {
        //selector(methodName) timeout is not a core function, this is something I will create
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    }
    else {
        NSLog(@"Error: selector missing!");
    }
}

#pragma mark - Helper methods

- (void)timeout {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
