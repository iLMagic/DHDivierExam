//
//  DHChapterBasicController.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/9.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHChapterExercise.h"
#import "DHSqliteTool.h"
#import "DHExamViewController.h"

@class DHChapterExercise;

@interface DHChapterBasicController : UITableViewController
@property (nonatomic, strong) NSArray<DHChapterExercise *> *models;

@end
