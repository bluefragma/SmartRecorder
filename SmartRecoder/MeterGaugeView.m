//
//  MeterGaugeView.m
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 12..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

// http://blog.naver.com/sei2001/201187990 Quartz 2D 개념

#import "MeterGaugeView.h"

#define GAUGE_WIDTH     70  // 계기침 길이
#define LINE_WIDTH      3   // 계기침 폭

#define STARTANGLE      225 // 오디오 최저 레벨일 때 계기침 각도
#define ENDANGLE        135 // 오디오 최고 레벨일 때 계기침 각도

@implementation MeterGaugeView

@synthesize  value;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UIImage *img = [UIImage imageNamed:@"guage.png"];
    imgGauge = CGImageRetain(img.CGImage);
    
    return self;
}

-(void) drawLine:(CGContextRef)context
{
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int StartX = self.bounds.size.width / 2;    // 계기침 시작 중심 X 좌표
    int StartY = self.bounds.size.height / 2 + 20;  // 계기침 시작 중심 Y좌표
    int newX, newY;     // 계기침 삼각형 꼭지점 X, Y 좌표
    int newStartX1, newStartX2; // 계기침 삼각형 좌/우 점의 X좌표
    int newStartY1, newStartY2; // ~~~~ Y좌표
    int newValue, newValue1, newValue2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGaugeBitmap:context];
    
    if (value >= 0.5) {
        newValue = ENDANGLE * 2 * (value - 0.5);        // 삼각형 계기침 좌표 계산
    } else {
        newValue = STARTANGLE + (360 - STARTANGLE) * 2 * value;
    }
    
    //  NSLog(@"%f  %d", value, newValue);
    if (newValue - 90 >= 0) {
        newValue1 = newValue - 90;
    } else {
        newValue1 = newValue - 90 + 360;
    }
    
    if (newValue + 90 <= 360) {
        newValue2 = newValue + 90 - 360;
    }
    
    newX = (int)(sin(newValue * 3.14/180) * GAUGE_WIDTH + StartX);
    newStartX1 = (int)(sin(newValue1 * 3.14/180 ) * LINE_WIDTH + StartX);
    newStartX2 = (int)(sin(newValue2 * 3.14/180 ) * LINE_WIDTH + StartX);
    
    newY = (int)(StartY - (cos(newValue * 3.14/180) * GAUGE_WIDTH ) );
    newStartY1 = (int)(StartY - (cos(newValue1 * 3.14/180 ) * LINE_WIDTH ) );
    newStartY2 = (int)(StartY - (cos(newValue2 * 3.14/180 ) * LINE_WIDTH ) );
    
    // 삼각형 계기침을 그립니다.
    CGContextSetRGBFillColor(context, 1.0, 0, 0, 1.0);
    
    CGContextMoveToPoint(context, newStartX1, newStartY1);
    CGContextAddLineToPoint(context, newStartX2, newStartY2);
    CGContextAddLineToPoint(context, newX, newY);
    CGContextAddLineToPoint(context, newStartX1, newStartY1);
    
    CGContextFillPath(context);
}

-(void) drawGaugeBitmap:(CGContextRef)context {
    // CTM(current transformation matrix)의 이전 상태 저장
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextClipToRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(imgGauge), CGImageGetHeight(imgGauge)), imgGauge);
    
    CGContextRestoreGState(context);
}

-(void) DrawValue:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)CenterY
{
    
}

@end
