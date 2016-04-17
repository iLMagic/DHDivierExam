//
//  DHQuestionView.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHQuestionView.h"
#import "DHDriverExam.h"
#import "DHChooseAnswerView.h"



@interface DHQuestionView() <DHChooseAnswerViewDeleagte>
@property (nonatomic, weak) UILabel *questionLabel;
@property (nonatomic, weak) UIView *answerView;

@property (nonatomic, weak) DHChooseAnswerView *answerA;
@property (nonatomic, weak) DHChooseAnswerView *answerB;
@property (nonatomic, weak) DHChooseAnswerView *answerC;
@property (nonatomic, weak) DHChooseAnswerView *answerD;

@property (nonatomic, weak) UILabel *remindLabel;
@property (nonatomic, weak) UILabel *reasonLabel;

@property (nonatomic, assign) NSInteger correctCount;

/** 存放答案View */
@property (nonatomic, strong) NSMutableArray<DHChooseAnswerView *> *answers;


@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation DHQuestionView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 1.初始化数组
        self.answers = @[].mutableCopy;
        
        UILabel *questionLabel = [UILabel new];
        questionLabel.numberOfLines = 0;
        questionLabel.font = [UIFont systemFontOfSize:20];
//        questionLabel.backgroundColor = [UIColor redColor];
        self.questionLabel = questionLabel;
        [self addSubview:questionLabel];
        
        UIImageView *imageView = [UIImageView new];
        self.imageView = imageView;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:imageView];
        
//        DHChooseAnswerView 
        
        DHChooseAnswerView *answerA = [self createAnswerBtn];
        self.answerA = answerA;
        DHChooseAnswerView *answerB = [self createAnswerBtn];
        self.answerB = answerB;
        DHChooseAnswerView *answerC = [self createAnswerBtn];
        self.answerC = answerC;
        DHChooseAnswerView *answerD = [self createAnswerBtn];
        self.answerD = answerD;
        for (int i = 0; i < self.answers.count; i ++) {
            DHChooseAnswerView *answer = self.answers[i];
            answer.tag = i + 1;
            answer.deleagte = self;
        }
        
        UILabel *remindLabel = [[UILabel alloc] init];
        [self addSubview:remindLabel];
        self.remindLabel = remindLabel;
        self.remindLabel.font = [UIFont systemFontOfSize:20];
        self.remindLabel.numberOfLines = 0;
        
        UILabel *reasonLabel = [[UILabel alloc] init];
        [self addSubview:reasonLabel];
        self.reasonLabel = reasonLabel;
        self.reasonLabel.font = [UIFont systemFontOfSize:20];
        self.reasonLabel.numberOfLines = 0;
        
        
    }
    
    return self;
}

- (DHChooseAnswerView *)createAnswerBtn
{
    DHChooseAnswerView *answerView = [[DHChooseAnswerView alloc] init];
    [self addSubview:answerView];
    [self.answers addObject:answerView];
    return answerView;
}

- (void)setDriverExam:(DHDriverExam *)driverExam
{
    _driverExam = driverExam;
    for (int i = 0; i < self.answers.count; i ++) {
        DHChooseAnswerView *answer = self.answers[i];
        answer.userInteractionEnabled = YES;
        answer.selected = NO;
    }
    
    self.questionLabel.left = 20;
    self.questionLabel.top = 20;
    NSString *questionString = [NSString stringWithFormat:@"%zd、%@", driverExam.index + 1, driverExam.topic];
    self.questionLabel.size = [NSString sizeWithString:questionString andMaxSize:CGSizeMake(ScreenWidth - 40, MAXFLOAT) andFont:[UIFont systemFontOfSize:20]];
    self.questionLabel.text = questionString;
    
    if (driverExam.picture) {
        self.imageView.size = CGSizeMake(ScreenWidth - 40, 200);
        self.imageView.left = 20;
        self.imageView.top = self.questionLabel.bottom +20;
        self.imageView.image = [UIImage imageNamed:driverExam.picturePath];
    } else
    {
        self.imageView.frame = CGRectMake(0, 0, 0, 0);
        self.imageView.bottom = self.questionLabel.bottom;
    }

//

    self.answerA.left = 20;
    self.answerA.top = self.imageView.bottom + 20;
    self.answerA.width = ScreenWidth - 40;
    self.answerA.answerString = [NSString stringWithFormat:@"A、%@",driverExam.option_a];
    
    self.answerB.left = 20;
    self.answerB.top = self.answerA.bottom;
    self.answerB.width = ScreenWidth - 40;
    self.answerB.answerString = [NSString stringWithFormat:@"B、%@",driverExam.option_b];
    
    if (driverExam.option_c) {
        self.answerC.left = 20;
        self.answerC.top = self.answerB.bottom;
        self.answerC.width = ScreenWidth - 40;
        self.answerC.answerString = [NSString stringWithFormat:@"C、%@",driverExam.option_c];
        self.answerD.left = 20;
        self.answerD.top = self.answerC.bottom;
        self.answerD.width = ScreenWidth - 40;
        self.answerD.answerString = [NSString stringWithFormat:@"D、%@",driverExam.option_d];
        self.answerC.hidden = NO;
        self.answerD.hidden = NO;
    } else {
        self.answerD.bottom = self.answerB.bottom;
        self.answerC.hidden = YES;
        self.answerD.hidden = YES;

    }
    
    self.remindLabel.hidden = YES;
    self.reasonLabel.hidden = YES;
    
    self.contentSize = CGSizeMake(ScreenWidth, self.answerD.bottom + 20);
    
}

- (void)chooseAnswerViewDidClick:(DHChooseAnswerView *)chooseAnswerView
{
    for (int i = 0; i < self.answers.count; i ++) {
        DHChooseAnswerView *answer = self.answers[i];
        answer.userInteractionEnabled = NO;
//        answer.selected = ;
    }
    self.remindLabel.hidden = NO;
    self.reasonLabel.hidden = NO;


    if (chooseAnswerView.tag == self.driverExam.answer) {
//        NSLog(@"正确");
        if ([self.delegateCustom respondsToSelector:@selector(questionViewChooseCorrectAnswer:)]) {
            [self.delegateCustom questionViewChooseCorrectAnswer:self];
        }
        self.remindLabel.text = @"恭喜您，答对啦！";
        self.remindLabel.textColor = [UIColor blackColor];
        self.correctCount ++;
        
//        [NSUserDefaults standardUserDefaults] setInteger:self.correctCount forKey:<#(nonnull NSString *)#>
        
    } else {
        NSLog(@"错误");
        self.remindLabel.textColor = [UIColor redColor];
        DHChooseAnswerView *correctAnswerView = self.answers[self.driverExam.answer - 1];
        
        NSString *correctAnswerString = correctAnswerView.answerString;
        
        self.remindLabel.text = [NSString stringWithFormat:@"您答错啦！正确答案是：%@",correctAnswerString];
    }
    
    self.remindLabel.width = ScreenWidth - 40;
    self.remindLabel.height = [NSString sizeWithString:self.remindLabel.text andMaxSize:CGSizeMake(self.remindLabel.width, MAXFLOAT) andFont:self.remindLabel.font].height;
    self.remindLabel.left = 20;
    self.remindLabel.top = self.answerD.bottom + 20;
    
    self.reasonLabel.width = ScreenWidth - 40;
    self.reasonLabel.height = [NSString sizeWithString:self.driverExam.analyze andMaxSize:CGSizeMake(self.reasonLabel.width, MAXFLOAT) andFont:self.remindLabel.font].height;
    self.reasonLabel.left = 20;
    self.reasonLabel.text = self.driverExam.analyze;
    self.reasonLabel.top = self.remindLabel.bottom + 20;
    
    self.contentSize = CGSizeMake(ScreenWidth, self.reasonLabel.bottom + 20);
//    if ([self.delegate respondsToSelector:@selector(questionView:currentCorrectCount:)]) {
//        [self.delegate questionView:self currentCorrectCount:self.correctCount];
//    }
}


@end
