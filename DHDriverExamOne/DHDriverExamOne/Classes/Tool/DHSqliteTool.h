//
//  DHSqliteTool.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DHDriverExam, DHChapterExercise;

@interface DHSqliteTool : NSObject

+ (instancetype)sharedSqliteTool;
/** 查询所有（顺序查找）*/
- (NSArray<DHDriverExam *> *)queryAllQuestion;
/** 查询所有（乱序查找）*/
- (NSArray<DHDriverExam *> *)queryRandomAllQuestion;

/** 查询章节（章节练习）*/
- (NSArray<DHChapterExercise *> *)queryChapterArray;
/** 查询题目(章节练习) */
- (NSArray<DHDriverExam *> *)queryChapterQuestionWithCid:(NSInteger)cid;
/** 查询章节（强化练习） */
- (NSArray<DHChapterExercise *> *)queryCategoryArray;
/** 查询题目(强化练习) */
- (NSArray<DHDriverExam *> *)queryCategoryQuestionWithCid:(NSInteger)cid;
/** 返回考试试题（100题） */
- (NSArray<DHDriverExam *> *)querySimulateExam;
@end
