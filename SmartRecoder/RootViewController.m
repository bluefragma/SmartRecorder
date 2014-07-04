//
//  RootViewController.m
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 4..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import "RootViewController.h"
#import "RecordViewController.h"
#import "AudioRecorderInfo.h"
#import "RecordListViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    // Do any additional setup after loading the view.
    
    RecordViewController *viewController = [[RecordViewController alloc] initWithNibName:@"RecordViewCntroller" bundle:nil];
    self.pRecordViewController = viewController;
    
    // infoButton 뒤로 RecordViewController.view 넣기
    [self.view insertSubview:viewController.view belowSubview:infoButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)RecordInfoClick:(id)sender {
    // AudioRecorderInfo.nib 파일 로드 후 개체 생성
    if (pAudioRecorderInfo == nil) {
        AudioRecorderInfo *viewController = [[AudioRecorderInfo alloc] initWithNibName:@"AudioRecorderInfo" bundle:nil];
        self.pAudioRecorderInfo = viewController;
    }
    
    UIView *RecordView = pRecordViewController.view;
    UIView *AudioRecorderInfoView = pAudioRecorderInfo.view;
    
    // 화면전환
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:([RecordView superview]?UIViewAnimationTransitionFlipFromRight:UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
    // 물음표 연산자는 하나의 조건문과 두 개의 수식으로 구성되며, if 문을 단순화 하고자 하는 경우에 주로 사용한다.
    // 형식 condition ? x:y;
    // 설명 (1) condition은 조건을 나타내는 식
    //     (2) x는 조건식(condition)이 참일 때 수행할 표현식(수식)
    //     (3) y는 조건식(condition)이 거짓일 때 수행할 표현식
    
    // 슈퍼 뷰에서 제거하여 더이상 화면에 나타나지 않게 함
    if ([RecordView superview] != nil) {
        [RecordView removeFromSuperview];
        [self.view addSubview:AudioRecorderInfoView];
    } else {
        [AudioRecorderInfoView removeFromSuperview];
        [self.view insertSubview:RecordView belowSubview:infoButton];
    }
    [UIView commitAnimations];
}

- (IBAction)AudioListClick:(id)sender {
    // RecordListViewController.xib 파일 로드 후 객체 생성
    if (pRecordListViewController == nil) {
        RecordListViewController *viewController = [[RecordListViewController alloc] initWithNibName:@"RecordListViewController" bundle:nil];
        self.pRecordListViewController = viewController;
    }
    
    UIView *RecordView = pRecordViewController.view;
    UIView *RecordListView = pRecordListViewController.view;
    
    // 화면 전환 설정
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:([RecordView superview]?UIViewAnimationTransitionCurlUp:UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
    if ([RecordView superview] != nil) {
        [RecordView removeFromSuperview];
        [self.view addSubview:RecordListView];
        [self.pRecordListViewController viewDidAppear:YES];
        [self.pRecordViewController viewDidAppear:NO];
    } else {
        [RecordListView removeFromSuperview];
        [self.view insertSubview:RecordView belowSubview:infoButton];
        [self.pRecordListViewController viewDidAppear:NO];
        [self.pRecordViewController viewDidAppear:YES];
    }
    [UIView commitAnimations];
}
@end
