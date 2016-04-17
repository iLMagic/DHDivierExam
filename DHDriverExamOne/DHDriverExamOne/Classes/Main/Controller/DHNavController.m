//
//  DHNavController.m
//  DHDriverExamOne
//  
//  Created by DH on 16/4/7.
//  Copyright © 2016年 DH. All rights reserved.
//

#import "DHNavController.h"

@interface DHNavController ()

@end

@implementation DHNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:DHRGB(203, 239, 107)];
    
    NSDictionary *attrs = @{
                            NSForegroundColorAttributeName : DHRGB(41, 134, 23),
                            NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
                            };
    [self.navigationBar setTitleTextAttributes:attrs];
}


@end
