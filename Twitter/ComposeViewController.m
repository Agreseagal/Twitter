//
//  ComposeViewController.m
//  Twitter
//
//  Created by Tripta Gupta on 3/27/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "ComposeViewController.h"
#import "User.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

@synthesize in_reply_to_status_id;
@synthesize current_status;

-(id)initWithNibName:(NSString *)nibNameOrNil andStatus:(NSString *)status bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.current_status = status;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil andStatus:(NSString *)status inReplyToTweetId:(NSString *)tweetId bundle:(NSBundle *)nibBundleOrNil
{
    self = [self initWithNibName:nibNameOrNil andStatus:status bundle:nibBundleOrNil];
    if (self) {
        self.in_reply_to_status_id = tweetId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(onDoneButton)];
    self.editing = YES;
    
    if (self.current_status.length == 0) {
        self.statusTextView.text = @"Enter your tweet here";
    }
    else {
        self.statusTextView.text = self.current_status;
    }
    
    User *user = [User currentUser];
    self.nameLabel.text = user.name;
    self.twitterHandleLabel.text = user.screen_name;
    [self.profileImageView setImageWithURL:[NSURL URLWithString: user.profile_image_url]];
    
    [self.statusTextView becomeFirstResponder];
}

- (void)onCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onDoneButton
{
    NSLog(@"onDoneButton");
    NSLog(@"Updating Status");
    
    [[TwitterClient instance] updateStatus:self.statusTextView.text success:^(AFHTTPRequestOperation *operation, id response) {
        //           NSString *testString = @"Well keep testing till you get it right";
        //          [[TwitterClient instance] updateStatus:testString success:^(AFHTTPRequestOperation *operation, id response) {
        
        NSLog(@"Status Updated. Now everyone knows about your cats");
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Twitter hates this update so much it's blocking your post: %@", error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
