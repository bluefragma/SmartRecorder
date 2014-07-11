//
//  MeterGaugeView.h
//  SmartRecoder
//
//  Created by 양동길 on 2014. 7. 12..
//  Copyright (c) 2014년 양동길. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeterGaugeView : UIView
{
    CGImageRef imgGauge;
}

-(void) drawLine:(CGContextRef)context;
-(void) drawGaugeBitmap:(CGContextRef)context;
-(void) DrawValue:(CGContextRef)context CenterX:(int)pCenterX CenterY:(int)CenterY;

@property double value;

@end
