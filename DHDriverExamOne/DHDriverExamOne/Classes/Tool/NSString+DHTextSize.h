//
//  NSString+DHTextSize.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DHTextSize)

+ (CGSize)sizeWithString:(NSString *)string andMaxSize:(CGSize)maxSize andFont:(UIFont *)font;

@end
