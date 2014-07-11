//
//  RecordViewController.h
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 4..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
// http://iosblog.tistory.com/4 아이폰으로 마이크로 부는 값을 체크해보자.
#import "MeterGaugeView.h"
#import "RecordDataBase.h"

@interface RecordViewController : UIViewController <AVAudioRecorderDelegate>
{
    AVAudioRecorder *pAudioRecoder;
    AVAudioSession *pAudioSession;
    
    IBOutlet UIButton *pRecordButton;   // 녹음 제어 버튼
    IBOutlet UILabel *recordTimeDisplay;
    
    IBOutlet MeterGaugeView *pGaugeView;
    IBOutlet UIBarButtonItem *ListButton;
    
    
    NSTimer *timer;
    double plowPassResults; // 녹음 레벨
    RecordDataBase *pDataBase;  // 데이터베이스 제어 클래스 변수
    
    // 데이터베이스에 저장하기 위한 정보
    NSString *pRecordSeq;
    NSString *pRecordFileName;
    int pRecordingTime;
}

- (IBAction)AudioRecordingClick:(id)sender; // 녹음 시작/멈춤 액션
- (NSString *)getFileName;  // 파일명 구하기
- (BOOL)SetAudioSession;    // 오디오 세션 설정 함수
- (BOOL)AudioRecordingStart;    // 녹음 시작
- (void) ToolbarRecordButtonTogle:(int)index;
- (void) timeFired;

@property (nonatomic, retain) AVAudioRecorder *pAudioRecorder;
@property (nonatomic, retain) AVAudioSession *pAudioSession;

@end