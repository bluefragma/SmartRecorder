//
//  RootViewController.h
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 4..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordViewController;
@class AudioRecorderInfo;
@class RecordListViewController;

@interface RootViewController : UIViewController
{
    RecordViewController *pRecordViewController;
    AudioRecorderInfo *pAudioRecorderInfo;
    RecordListViewController *pRecordListViewController;
    
    IBOutlet UIButton *infoButton;
}
- (IBAction)RecordInfoClick:(id)sender;
- (IBAction)AudioListClick:(id)sender;

@property (nonatomic, strong)RecordViewController *pRecordViewController;
@property (nonatomic, strong)AudioRecorderInfo *pAudioRecorderInfo;
@property (nonatomic, strong)RecordListViewController *pRecordListViewController;
@end
