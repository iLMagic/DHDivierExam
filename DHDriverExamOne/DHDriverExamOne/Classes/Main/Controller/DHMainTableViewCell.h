//
//  DHMainTableViewCell.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHMainTableViewCell : UITableViewCell

+ (instancetype)mainTableViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *titleString;

@end
