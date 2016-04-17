//
//  DHDriverExam.m
//  驾考宝典网页数据分析
//
//  Created by DH on 16/4/6.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHDriverExam.h"

@implementation DHDriverExam

- (NSString *)picturePath
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"picture.bundle" ofType:nil];
    
    NSString *filePath = [NSString stringWithFormat:@"%@%@", path, self.picture];
    
    return filePath;
}
@end
