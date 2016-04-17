//
//  NSString+DHTextSize.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "NSString+DHTextSize.h"

@implementation NSString (DHTextSize)

+ (CGSize)sizeWithString:(NSString *)string andMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    
    NSDictionary *attr = @{NSFontAttributeName : font};
   return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
