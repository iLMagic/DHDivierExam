//
//  DHChapterExerciseViewController.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/9.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHChapterExerciseViewController.h"

@interface DHChapterExerciseViewController()

@end

@implementation DHChapterExerciseViewController


#pragma mark -- tableView delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DHChapterExercise *chapterExercise = self.models[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转控制器
    DHExamViewController *examVC = [[DHExamViewController alloc] init];
    examVC.titleSting = @"章节练习";
    [self.navigationController pushViewController:examVC animated:YES];
    examVC.questionArray = [[DHSqliteTool sharedSqliteTool] queryChapterQuestionWithCid:chapterExercise.cid];
}

@end
