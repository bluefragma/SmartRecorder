//
//  RecordViewController.m
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 4..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

@synthesize pAudioRecorder;
@synthesize pAudioSession;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self SetAudioSession]; // 오디오 동작 설정
    [recordTimeDisplay setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:48.0]];
    pDataBase = [[RecordDataBase alloc] init];
}

- (BOOL)SetAudioSession
{
    self.pAudioSession = [AVAudioSession sharedInstance];
    // 오디오 카테고리를 설정합니다.
    // AVAudioSessionCategoryPlayAndRecord : 잠금 이벤트에 반응하지 않게 설정하는 상수 값
    if (![self.pAudioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil])
        return  NO;
    if (![self.pAudioSession setActive:YES error:nil])  // 오디오 세션이 활성화 됨
        return NO;
    return self.pAudioSession.isOtherAudioPlaying;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AudioRecordingClick:(id)sender {
    if (self.pAudioRecorder !=nil)
    {
        if(self.pAudioRecorder.recording) {  // 레코딩 중일 경우
            [self.pAudioRecorder stop];  // 녹음 중지
            pGaugeView.value = 0;
            
            // 오디오 레벨을 표시하는 계기판을 다시 그림
            [pGaugeView setNeedsDisplay];
            return;
        }
        [[NSFileManager defaultManager] removeItemAtPath:[self.pAudioRecorder.url path] error:nil];
    }
    if ([self AudioRecordingStart])    // 녹음 시작
    {
        [self ToolbarRecordButtonTogle:1];
        // 타이머 설정
        timer = [NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(timeFired) userInfo:nil repeats:YES];
    }
}

- (BOOL)AudioRecordingStart
{
    NSMutableDictionary *AudioSettting = [NSMutableDictionary dictionary];
	[AudioSettting setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
	[AudioSettting setValue: [NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
	[AudioSettting setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey]; // mono
	[AudioSettting setValue: [NSNumber numberWithInt:8] forKey:AVLinearPCMBitDepthKey];
	[AudioSettting setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
	[AudioSettting setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    // 녹음된 오디오가 저장된 파일의 URL
 	NSURL *url = [self getAudioFilePath];
	
	// AVAudioRecorder 객체 생성
	self.pAudioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:AudioSettting error:nil];
	if (!self.pAudioRecorder) return NO;
    
	self.pAudioRecorder.meteringEnabled = YES;  // 모니터링 여부를 설정합니다.
	self.pAudioRecorder.delegate = self;
    
	
	if (![self.pAudioRecorder prepareToRecord])      // 녹음 준비 여부 확인
        return NO;
	
	if (![self.pAudioRecorder record])    // 녹음시작
		return NO;
	
	return YES;
}

- (NSURL *)getAudioFilePath
{
    //Documents 경로 구하기
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
    
    // 파일명을 구하기 + 경로 합치기 + NSURL 객체 변환
	NSURL *AudioUrl = [NSURL fileURLWithPath:[documentDirectory stringByAppendingPathComponent:[self getFileName]]];
    return AudioUrl;
}

- (NSString *) getFileName
{
	NSDateFormatter *FileNameFormat = [[NSDateFormatter alloc] init];
	[FileNameFormat setDateFormat:@"yyyyMMddHHmmss"];
    
    //파일명 구하기
	NSString *FileNameStr =  [[FileNameFormat stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
    
    NSLog(@"%@", FileNameStr);
    return FileNameStr;
}

// 녹음/멈품 버튼 이미지 토글 처리
- (void) ToolbarRecordButtonTogle:(int)index
{
    if (index == 0) {
        [pRecordButton setImage:[UIImage imageNamed:@"record_on.png"] forState:UIControlStateNormal];
    } else {
        [pRecordButton setImage:[UIImage imageNamed:@"record_off.png"] forState:UIControlStateNormal];
    }
}

- (void) timeFired
{
    // 현재 측정레벨 재설정
	[self.pAudioRecorder updateMeters];
    
    double peak = pow(10, (0.05 * [self.pAudioRecorder peakPowerForChannel:0]));
    plowPassResults = 0.05 * peak + (1.0 - 0.05) * plowPassResults;
    
	// 녹음 시간 화면에 업데이트
	recordTimeDisplay.text = [NSString stringWithFormat:@"%@", [self RecordTime:self.pAudioRecorder.currentTime]];
    pRecordingTime = self.pAudioRecorder.currentTime;
    
    pGaugeView.value = plowPassResults;
    [pGaugeView setNeedsDisplay];   // 계기판을 다시 그리기
}

//녹음된 시/분/초 구하기
- (NSString *) RecordTime: (int) num
{
	int secs = num % 60;            // 녹음시간 : 초
	int min = (num % 3600) / 60;    // 녹음시간 : 분
    int hour =(num / 3600);         // 녹음시간 : 시
    
	return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min, secs];
}

@end
