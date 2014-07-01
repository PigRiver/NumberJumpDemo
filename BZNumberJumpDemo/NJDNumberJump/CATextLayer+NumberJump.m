//
//  CATextLayer+NumberJump.m
//  BZNumberJumpDemo
//
//  Created by Bruce on 14-7-1.
//  Copyright (c) 2014年 com.Bruce.Number. All rights reserved.
//

#import "CATextLayer+NumberJump.h"

#define kPointsNumber 100 // 即数字跳100次
#define kDurationTime 5.0 // 动画时间
#define kStartNumber  0   // 起始数字
#define kEndNumber    1000// 结束数字

@implementation CATextLayer (NumberJump)

NSMutableArray *numberPoints;//记录每次textLayer更改值的间隔时间及输出值。
float lastTime;
int indexNumber;

Point2D startPoint;
Point2D controlPoint1;
Point2D controlPoint2;
Point2D endPoint;

int _duration;
float _startNumber;
float _endNumber;

- (void)cleanUpValue {
    lastTime = 0;
    indexNumber = 0;
    self.string = [NSString stringWithFormat:@"%.0f",_startNumber];
}

- (void)jumpNumberWithDuration:(int)duration
                    fromNumber:(float)startNumber
                      toNumber:(float)endNumber {
    _duration = duration;
    _startNumber = startNumber;
    _endNumber = endNumber;
    
    [self cleanUpValue];
    [self initPoints];
    [self changeNumberBySelector];
}

- (void)jumpNumber {
    [self jumpNumberWithDuration:kDurationTime fromNumber:kStartNumber toNumber:kEndNumber];
}

- (void)initPoints {
    // 贝塞尔曲线
    [self initBezierPoints];
    Point2D bezierCurvePoints[4] = {startPoint, controlPoint1, controlPoint2, endPoint};
    numberPoints = [[NSMutableArray alloc] init];
    float dt;
    dt = 1.0 / (kPointsNumber - 1);
    for (int i = 0; i < kPointsNumber; i++) {
        Point2D point = PointOnCubicBezier(bezierCurvePoints, i*dt);
        float durationTime = point.x * _duration;
        float value = point.y * (_endNumber - _startNumber) + _startNumber;
        [numberPoints addObject:[NSArray arrayWithObjects:[NSNumber numberWithFloat:durationTime], [NSNumber numberWithFloat:value], nil]];
    }
}

- (void)initBezierPoints {
    // 可到http://cubic-bezier.com自定义贝塞尔曲线
    
    startPoint.x = 0;
    startPoint.y = 0;
    
    controlPoint1.x = 0.25;
    controlPoint1.y = 0.1;
    
    controlPoint2.x = 0.25;
    controlPoint2.y = 1;
    
    endPoint.x = 1;
    endPoint.y = 1;
}

- (void)changeNumberBySelector {
    if (indexNumber >= kPointsNumber) {
        self.string = [NSString stringWithFormat:@"%.0f",_endNumber];
        return;
    } else {
        NSArray *pointValues = [numberPoints objectAtIndex:indexNumber];
        indexNumber++;
        float value = [(NSNumber *)[pointValues objectAtIndex:1] intValue];
        float currentTime = [(NSNumber *)[pointValues objectAtIndex:0] floatValue];
        float timeDuration = currentTime - lastTime;
        lastTime = currentTime;
        self.string = [NSString stringWithFormat:@"%.0f",value];
        [self performSelector:@selector(changeNumberBySelector) withObject:nil afterDelay:timeDuration];
    }
}

@end
