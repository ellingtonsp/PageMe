//
//  CameraViewController.h
//  ribbit
//
//  Created by Brian Chou on 11/16/14.
//  Copyright (c) 2014 com.Brian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CameraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong, nonatomic) UIImagePickerController *imagePicker;
@property(strong, nonatomic) UIImage *image;
@property(strong, nonatomic) NSString *videoFilePath;
@property(strong, nonatomic) NSArray *friends;
@property(strong, nonatomic) PFRelation *friendsRelation;
@property(strong, nonatomic) NSMutableArray * recipients;

- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;
- (void)uploadMessage;
- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;

@end
