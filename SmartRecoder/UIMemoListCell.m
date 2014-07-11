//
//  UIMemoListCell.m
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 12..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import "UIMemoListCell.h"

@implementation UIMemoListCell

@synthesize pDateLabel;
@synthesize pTimeLabel;
@synthesize pRecodingTimeLabel;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
