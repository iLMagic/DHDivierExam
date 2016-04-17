//
//  DHExamViewController.m
//  DHDriverExamOne
//
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHExamViewController.h"
#import "DHSqliteTool.h"
#import "DHExamCollectionViewCell.h"
#import "DHDriverExam.h"

@interface DHExamViewController ()<DHExamCollectionViewCellDelegate>


@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger correctCount;

@end

@implementation DHExamViewController

static NSString * const reuseIdentifier = @"exam";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleSting;
    // 注册
    [self.collectionView registerClass:[DHExamCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - 64);
//    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    self.collectionView.pagingEnabled = YES;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 添加一个定时器
//    [self createTimer];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"%@",self.timer);
    
    // 这两句代码顺序不能乱
    [self.timer invalidate];
    // 切记切记
    self.timer = nil;
}

- (void)createTimer
{
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:20];
    timeLabel.textColor = [UIColor redColor];
    timeLabel.width = 60;
    timeLabel.height =30;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel = timeLabel;
    self.navigationItem.titleView = timeLabel;
    // 初始值45：00
    timeLabel.text = @"45:00";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDidChange) userInfo:nil repeats:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitBtnDidClick)];
}

- (void)submitBtnDidClick
{
    NSString *message = [NSString stringWithFormat:@"分数： %zd", self.correctCount];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"考试成绩" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"再来一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.timeLabel.text = @"45:00";
        [self createTimer];
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)timeDidChange
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"mm:ss";
    NSDate *timeDate = [dateFormatter dateFromString:self.timeLabel.text];
    NSDate *currentTimeDate = [NSDate dateWithTimeInterval: -1.0 sinceDate:timeDate];
    NSString *timeString = [dateFormatter stringFromDate:currentTimeDate];
    self.timeLabel.text = timeString;
    if ([timeString isEqualToString:@"00:00"]) {
        [self submitBtnDidClick];
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    return [self initWithCollectionViewLayout:flowLayout];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.questionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DHExamCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor randomColor];
    cell.backgroundColor = [UIColor whiteColor];
    DHDriverExam *driverExam = self.questionArray[indexPath.item];

    driverExam.index = indexPath.row;
    cell.driverExam = driverExam;
    cell.delegate = self;
    return cell;
}

- (void)examCollectionViewCellDidChooseCorrectAnswer
{
    self.correctCount ++;
}

@end
