//
//  DHExamCollectionViewCell.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DHExamCollectionViewCellDelegate <NSObject>

- (void)examCollectionViewCellDidChooseCorrectAnswer;

@end

@class DHDriverExam;
@interface DHExamCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) DHDriverExam *driverExam;
@property (nonatomic, weak) id<DHExamCollectionViewCellDelegate> delegate;
@end
