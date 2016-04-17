//
//  DHSqliteTool.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHSqliteTool.h"
#import <FMDB.h>
#import "DHDriverExam.h"
#import "DHChapterExercise.h"

@interface DHSqliteTool()

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end

@implementation DHSqliteTool

static DHSqliteTool *_instance;

+ (instancetype)sharedSqliteTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DHSqliteTool alloc] init];
        // 开启数据库
        NSString *path = [[NSBundle mainBundle] pathForResource:@"examine.db" ofType:nil];
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
        _instance.databaseQueue = queue;
    });
    return _instance;
}

/** 查询所有（顺序查询） */
- (NSArray<DHDriverExam *> *)queryAllQuestion
{
    NSString *sql = @"select * from examine_question;";
    return [self queryArrayWithSqlString:sql andModelClassName:[DHDriverExam class]];
}
/** 查询所有（乱序查询） */
- (NSArray<DHDriverExam *> *)queryRandomAllQuestion
{
    NSMutableArray *array = [self queryAllQuestion].mutableCopy;
    for (int i = 0; i < array.count; ++ i) {
        // 打乱一个数组
        NSInteger randomValue1 = arc4random() % array.count;
        NSInteger randomValue2 = arc4random() % array.count;
        if (randomValue1 != randomValue2) {
            // 交换位置
            id temp = array[randomValue1];
            array[randomValue1] = array[randomValue2];
            array[randomValue2] = temp;
        }
    }
    return array;
}

/** 查询章节(章节练习) */
- (NSArray<DHChapterExercise *> *)queryChapterArray
{
    NSString *sql = @"select * from examine_chapter where pid = 0;";
    return [self queryArrayWithSqlString:sql andModelClassName:[DHChapterExercise class]];
}
/** 查询题目(章节练习) */
- (NSArray<DHDriverExam *> *)queryChapterQuestionWithCid:(NSInteger)cid
{
    NSString *sql = [NSString stringWithFormat:@"select * from examine_question where cid = %zd;", cid];
    return [self queryArrayWithSqlString:sql andModelClassName:[DHDriverExam class]];
}
- (NSArray<DHDriverExam *> *)querySimulateExam
{
    NSMutableArray *array = @[].mutableCopy;
    for (int i = 1; i < 5; ++ i) {
        NSArray *subArray = [self queryChapterQuestionWithCid:i];
        // 随机数组
        NSArray *randomValues = [self randomValueArray:25 scope:subArray.count];
        NSLog(@"%@",randomValues);
        NSMutableArray *subTempArray = @[].mutableCopy;
        for (NSNumber *value in randomValues) {
            NSInteger valueInteger = [value integerValue];
            [subTempArray addObject:subArray[valueInteger]];
        }
        [array addObjectsFromArray:subTempArray];
    }
    NSLog(@"%zd",array.count);
    return array;
}

/** 查询章节（强化练习） */
- (NSArray<DHChapterExercise *> *)queryCategoryArray
{
    NSString *sql = @"select * from examine_category where pid = 0;";
    return [self queryArrayWithSqlString:sql andModelClassName:[DHChapterExercise class]];
}

/** 查询题目(强化练习) */
- (NSArray<DHDriverExam *> *)queryCategoryQuestionWithCid:(NSInteger)cid
{
    
    // 创建一个数组用来存放qid
    NSMutableArray *qidArray = @[].mutableCopy;
    // 根据cid 去 examine_relationship 表里面查找对应的qid
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat: @"select qid from examine_relationship where cid = %zd;", cid];
        FMResultSet *result = [db executeQuery:sql];
        while (result.next) {
            NSInteger qid = [result longForColumn:@"qid"];
            [qidArray addObject:@(qid)];
        }
    }];
    
    // 创建一个可变数组
    NSMutableArray *modelArray = @[].mutableCopy;
    for (int i = 0; i < qidArray.count; ++ i) {
        // 查询语句
        NSInteger qid = [qidArray[i] integerValue];
        NSString *sql = [NSString stringWithFormat:@"select * from examine_question where qid = %zd", qid];
        [self.databaseQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *result = [db executeQuery:sql];
            while (result.next) {
                // 创建一个可变字典
                NSMutableDictionary *dict = @{}.mutableCopy;
                for (int i = 0; i < result.columnCount; ++ i) {
                    dict[[result columnNameForIndex:i]] = [result stringForColumnIndex:i];
                }
                DHDriverExam *exam = [DHDriverExam yy_modelWithDictionary:dict];
                [modelArray addObject:exam];
            }
        }];
    }
    
    return modelArray;
}
/** 根据sql语句来查询数据，返回的是对应的模型数组 */
- (id)queryArrayWithSqlString:(NSString *)sqlString andModelClassName:(Class)modelClass
{
    // 创建一个可变数组用来
    NSMutableArray *modelArray = @[].mutableCopy;
    // 查询语句
    NSString *sql = sqlString;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while (result.next) {
            // 创建一个可变字典
            NSMutableDictionary *dict = @{}.mutableCopy;
            for (int i = 0; i < result.columnCount; ++ i) {
                dict[[result columnNameForIndex:i]] = [result stringForColumnIndex:i];
            }
            NSObject *model = [modelClass yy_modelWithDictionary:dict];
            [modelArray addObject:model];
        }
    }];
    return modelArray;
}

/** 产生随机数数组 */
- (NSArray *)randomValueArray:(NSInteger)count scope:(NSInteger)scope
{
    NSMutableArray *randomValues = @[].mutableCopy;
    while (randomValues.count < count) {
        NSInteger value = random() % scope;
        BOOL ID = NO;
        for (int i = 0; i < randomValues.count; ++ i) {
            NSInteger perValue = [randomValues[i] integerValue];
            while (perValue == value) {
                ID = YES;
                break;
            }
        }
        if (ID == NO) {
            [randomValues addObject:@(value)];
        }
    }
    return randomValues;
}


@end
