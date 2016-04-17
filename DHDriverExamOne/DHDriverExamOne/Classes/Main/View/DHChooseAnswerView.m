//
//  DHChooseAnswerView.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/8.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHChooseAnswerView.h"

@interface DHChooseAnswerView()

@property (nonatomic, weak) UILabel *answerLabel;
@property (nonatomic, weak) UIImageView *chooseImageView;

@end

@implementation DHChooseAnswerView


- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (_selected) {
        self.chooseImageView.image = [UIImage imageNamed:@"btn_radio_on"];
    } else {
        self.chooseImageView.image = [UIImage imageNamed:@"btn_radio_off"];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = DHRGB(252, 247, 247);
        
     
        UILabel *answerLabel = [[UILabel alloc] init];
        answerLabel.font = [UIFont systemFontOfSize:20];
        self.answerLabel = answerLabel;
        [self addSubview:answerLabel];
        answerLabel.numberOfLines = 0;
//        answerLabel.backgroundColor = [UIColor whiteColor];
        
        UIImageView *chooseImageView = [[UIImageView alloc] init];
        self.chooseImageView = chooseImageView;
//        chooseImageView.backgroundColor = [UIColor grayColor];
        chooseImageView.contentMode = UIViewContentModeCenter;
        
        [self addSubview:chooseImageView];
        self.chooseImageView.image = [UIImage imageNamed:@"btn_radio_off"];
        // 添加手势
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAnswerViewDidTap)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)setAnswerString:(NSString *)answerString
{
    _answerString = answerString;
    self.answerLabel.text = answerString;
    self.chooseImageView.left = 0;
    self.chooseImageView.top = 0;
    self.chooseImageView.width = 40;
//    self.chooseImageView.height = self.height;
    
    CGFloat margin = 8;
    self.answerLabel.left = self.chooseImageView.right + margin;
    self.answerLabel.top = margin;
    self.answerLabel.width = self.width - self.chooseImageView.width - margin * 2;
    
    self.answerLabel.size = [NSString sizeWithString:answerString andMaxSize:CGSizeMake(self.answerLabel.width, MAXFLOAT) andFont:self.answerLabel.font];

    self.height = self.answerLabel.size.height + margin * 2;
    self.chooseImageView.height = self.height;
}

/** 处理点击事件 */
- (void)chooseAnswerViewDidTap
{
    self.selected = YES;
    if ([self.deleagte respondsToSelector:@selector(chooseAnswerViewDidClick:)]) {
        [self.deleagte chooseAnswerViewDidClick:self];
    }
}

@end
