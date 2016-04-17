//
//  DHQuestionView.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DHQuestionView;
@protocol DHQuestionViewDeleagte <NSObject>

- (void)questionView:(DHQuestionView *)questionView currentCorrectCount:(NSInteger)correctCount;
- (void)questionViewChooseCorrectAnswer:(DHQuestionView *)questionView;

@end

@class DHDriverExam;

@interface DHQuestionView : UIScrollView
@property (nonatomic, strong) DHDriverExam *driverExam;

@property (nonatomic, weak) id<DHQuestionViewDeleagte> delegateCustom;

@end
