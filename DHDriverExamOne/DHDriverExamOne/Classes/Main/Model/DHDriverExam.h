//
//  DHDriverExam.h
//  驾考宝典网页数据分析
//
//  Created by DH on 16/4/6.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHDriverExam : NSObject

@property (nonatomic, assign) NSInteger qid;

@property (nonatomic, copy) NSString *topic;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger answer;

@property (nonatomic, copy) NSString *analyze;

@property (nonatomic, copy) NSString *option_a;

@property (nonatomic, copy) NSString *option_b;

@property (nonatomic, copy) NSString *option_c;

@property (nonatomic, copy) NSString *option_d;

@property (nonatomic, assign) NSInteger cid;

@property (nonatomic, copy) NSString *picturePath;

@property (nonatomic, assign) NSInteger index;

@end
