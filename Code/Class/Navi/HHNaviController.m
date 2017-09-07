//
//  HHNaviController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHNaviController.h"

@interface HHNaviController ()

@end

@implementation HHNaviController

- (void)loadView
{
    [super loadView];
    self.view.frame = [[UIScreen mainScreen]bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    [self locateMapViewInView:self.view frame:rect completion:nil];
    
    
    
}








@end


















