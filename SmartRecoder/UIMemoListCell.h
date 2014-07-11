//
//  UIMemoListCell.h
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 12..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMemoListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *pDateLabel;             // 녹음 날짜
@property (strong, nonatomic) IBOutlet UILabel *pRecodingTimeLabel;     // 녹음 시작 시간
@property (strong, nonatomic) IBOutlet UILabel *pTimeLabel;             // 녹음 시간
@end
