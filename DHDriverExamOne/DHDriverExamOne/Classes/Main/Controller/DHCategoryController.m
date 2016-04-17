//
//  DHCategoryController.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/9.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHCategoryController.h"

@implementation DHCategoryController

#pragma mark -- tableView delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DHChapterExercise *chapterExercise = self.models[indexPath.row];
    // 跳转控制器
    DHExamViewController *examVC = [[DHExamViewController alloc] init];
    examVC.titleSting = @"强化练习";
    [self.navigationController pushViewController:examVC animated:YES];
    examVC.questionArray = [[DHSqliteTool sharedSqliteTool] queryCategoryQuestionWithCid:chapterExercise.cid];
}

@end
