//
//  NJDBezierCurve.m
//  BZNumberJumpDemo
//
//  Created by Bruce on 14-7-1.
//  Copyright (c) 2014年 com.Bruce.Number. All rights reserved.
//

#import "NJDBezierCurve.h"

@implementation NJDBezierCurve
/* cp 在此是四个元素的数组:
 cp[0] 为起点，或上图中的 P0
 cp[1] 为第一控制点，或上图中的 P1
 cp[2] 为第二控制点，或上图中的 P2
 cp[3] 为结束点，或上图中的 P3
 t 为参数值，0 <= t <= 1 */
Point2D PointOnCubicBezier( Point2D* cp, float t )
{
    //    x = (1-t)^3 *x0 + 3*t*(1-t)^2 *x1 + 3*t^2*(1-t) *x2 + t^3 *x3
    //    y = (1-t)^3 *y0 + 3*t*(1-t)^2 *y1 + 3*t^2*(1-t) *y2 + t^3 *y3
    float   ax, bx, cx;
    float   ay, by, cy;
    float   tSquared, tCubed;
    Point2D result;
    
    /*計算多項式係數*/
    
    cx = 3.0 * (cp[1].x - cp[0].x);
    bx = 3.0 * (cp[2].x - cp[1].x) - cx;
    ax = cp[3].x - cp[0].x - cx - bx;
    
    cy = 3.0 * (cp[1].y - cp[0].y);
    by = 3.0 * (cp[2].y - cp[1].y) - cy;
    ay = cp[3].y - cp[0].y - cy - by;
    
    /*計算位於參數值t的曲線點*/
    
    tSquared = t * t;
    tCubed = tSquared * t;
    
    result.x = (ax * tCubed) + (bx * tSquared) + (cx * t) + cp[0].x;
    result.y = (ay * tCubed) + (by * tSquared) + (cy * t) + cp[0].y;
    
    return result;
}

@end
