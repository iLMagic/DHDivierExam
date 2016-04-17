//
//  DHChapterBasicController.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/9.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHChapterBasicController.h"

@implementation DHChapterBasicController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置行高
    self.tableView.rowHeight = 60;
}

#pragma mark -- <tableView dataSource methods>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"chapter";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    // 先对indexPathde row取模，因为图片就五张
    int index = (indexPath.row) % 5 + 1;
    //    NSLog(@"%d",index);
    NSString *imageName = [NSString stringWithFormat:@"examine_chapter_index_%d",index];
    cell.imageView.image = [UIImage imageNamed:imageName];
    DHChapterExercise *chapterExercise = self.models[indexPath.row];
    cell.textLabel.text = chapterExercise.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd题",chapterExercise.count];
    return cell;
}

@end
