//
//  DHMainTableViewCell.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHMainTableViewCell.h"
#import <Masonry.h>
@interface DHMainTableViewCell()

@property (nonatomic, weak) UILabel *label;

@end

@implementation DHMainTableViewCell

+ (instancetype)mainTableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"main";
    DHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DHMainTableViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        self.label = label;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = DHRGB(203, 239, 107);
        label.textColor = DHRGB(41, 134, 23);
        label.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:label];
        // 设置约束
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.height.offset(44);
            make.width.offset(300);
        }];
        
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.label.text = titleString;
}
@end
