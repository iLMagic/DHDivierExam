//
//  DHExamCollectionViewCell.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHExamCollectionViewCell.h"
#import "DHQuestionView.h"
#import "DHDriverExam.h"

@interface DHExamCollectionViewCell()<DHQuestionViewDeleagte>

@property (nonatomic, weak) DHQuestionView *questionView;
@end

@implementation DHExamCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        [self.contentView addSubview:btn];
        
        // 创建一个tableView
        DHQuestionView *questionView = [[DHQuestionView alloc] init];
        self.questionView = questionView;
        questionView.delegateCustom = self;
        [self.contentView addSubview:questionView];
        // 设置约束
        [questionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setDriverExam:(DHDriverExam *)driverExam
{
    _driverExam = driverExam;
    self.questionView.driverExam = driverExam;
    
//    NSLog(@"%@",driverExam.topic);
}

- (void)questionViewChooseCorrectAnswer:(DHQuestionView *)questionView
{
    if ([self.delegate respondsToSelector:@selector(examCollectionViewCellDidChooseCorrectAnswer)]) {
        [self.delegate examCollectionViewCellDidChooseCorrectAnswer];
    }
}
@end
