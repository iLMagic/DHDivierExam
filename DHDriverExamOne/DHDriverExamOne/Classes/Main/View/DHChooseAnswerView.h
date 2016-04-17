//
//  DHChooseAnswerView.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/8.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHChooseAnswerView;

@protocol DHChooseAnswerViewDeleagte <NSObject>

- (void)chooseAnswerViewDidClick:(DHChooseAnswerView *)chooseAnswerView;

@end

@interface DHChooseAnswerView : UIView

@property (nonatomic, copy) NSString *answerString;

/** 是否选中 */
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, weak) id<DHChooseAnswerViewDeleagte> deleagte;
@end