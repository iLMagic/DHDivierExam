//
//  UIColor+randomColor.m
//  联动
//
//  Created by DH on 16/3/15.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "UIColor+randomColor.h"

@implementation UIColor (randomColor)
+ (UIColor *)randomColor
{
    CGFloat red = (arc4random() % 256) / 255.0;
    CGFloat green = (arc4random() % 256) / 255.0;
    CGFloat blue = (arc4random() % 256) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
