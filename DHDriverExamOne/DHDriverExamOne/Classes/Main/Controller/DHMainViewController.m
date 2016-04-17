//
//  DHMainViewController.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHMainViewController.h"
#import <Masonry.h>
#import "DHMainTableViewCell.h"
#import "DHExamViewController.h"
#import "DHSqliteTool.h"
#import "DHChapterExerciseViewController.h"
#import "DHCategoryController.h"
@interface DHMainViewController ()
@property (nonatomic, strong) NSArray *models;
@end

@implementation DHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"驾考科目一";
    self.models = @[@"顺序练习", @"随机练习", @"章节练习", @"强化练习", @"模拟考试", @"错题集"];
    self.tableView.rowHeight = 60;
    [self setImageView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



- (void)setImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"examine_brochure"]];
    imageView.width = ScreenWidth;
    imageView.left = 0;
    imageView.top = 0;
    imageView.height = 200;
    // 设置文字
    UILabel *label1 = [[UILabel alloc] init];
    [imageView addSubview:label1];
    label1.text = @"帮你考试一次通过哦，";
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(40);
        make.top.equalTo(imageView).offset(80);
    }];

    UILabel *label2 = [[UILabel alloc] init];
    [imageView addSubview:label2];
    label2.text = @"亲，你还在等什么？";
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(-10);
        make.top.equalTo(label1.mas_bottom).offset(20);
    }];
    self.tableView.tableHeaderView = imageView;
}

#pragma mark -- tableView dataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DHMainTableViewCell *cell = [DHMainTableViewCell mainTableViewCellWithTableView:tableView];
    cell.titleString = self.models[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
    if (indexPath.row == 0) { // 顺序练习
        DHExamViewController *examVC = [[DHExamViewController alloc] init];
        [self.navigationController pushViewController:examVC animated:YES];
        examVC.titleSting = self.models[indexPath.row];
        examVC.questionArray = [DHSqliteTool sharedSqliteTool].queryAllQuestion;
    } else if (indexPath.row == 1) { // 随机练习
        DHExamViewController *examVC = [[DHExamViewController alloc] init];
        [self.navigationController pushViewController:examVC animated:YES];
        examVC.titleSting = self.models[indexPath.row];
        examVC.questionArray = [DHSqliteTool sharedSqliteTool].queryRandomAllQuestion;
    } else if (indexPath.row == 2) { // 章节练习
        DHChapterExerciseViewController *chapterExerciseVC = [[DHChapterExerciseViewController alloc] init];
        [self.navigationController pushViewController:chapterExerciseVC animated:YES];
        chapterExerciseVC.models = [[DHSqliteTool sharedSqliteTool] queryChapterArray];
    } else if (indexPath.row == 3) { // 强化练习
        DHCategoryController *categoryC = [[DHCategoryController alloc] init];
        [self.navigationController pushViewController:categoryC animated:YES];
        categoryC.models = [[DHSqliteTool sharedSqliteTool] queryCategoryArray];
        
    } else if (indexPath.row == 4) { // 模拟考试
        DHExamViewController *examVC = [[DHExamViewController alloc] init];
        [self.navigationController pushViewController:examVC animated:YES];
        examVC.titleSting = self.models[indexPath.row];
        examVC.questionArray = [DHSqliteTool sharedSqliteTool].querySimulateExam;
        [examVC createTimer];
    } else if (indexPath.row == 4) { // 错题集
        
    }
}
@end
