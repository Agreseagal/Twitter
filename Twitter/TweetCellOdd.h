//
//  TweetCellOdd.h
//  Twitter
//
//  Created by Òscar Muntal on 02/03/16.
//  Copyright (c) 2016 Tripta Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCellOdd : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@end
