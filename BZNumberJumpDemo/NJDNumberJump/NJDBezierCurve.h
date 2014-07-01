//
//  NJDBezierCurve.h
//  BZNumberJumpDemo
//
//  Created by Bruce on 14-7-1.
//  Copyright (c) 2014年 com.Bruce.Number. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
    float x;
    float y;
} Point2D;

@interface NJDBezierCurve : NSObject

Point2D PointOnCubicBezier(Point2D* cp, float t);

@end
