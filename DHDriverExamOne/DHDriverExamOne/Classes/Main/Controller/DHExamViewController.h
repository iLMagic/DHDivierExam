//
//  DHExamViewController.h
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHExamViewController : UICollectionViewController

@property (nonatomic, copy) NSString *titleSting;

@property (nonatomic, strong) NSArray *questionArray;
/** 创建一个控制器 */
- (void)createTimer;
@end
