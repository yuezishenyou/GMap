//
//  HHSearchController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSearchController.h"

@interface HHSearchController ()

@end

@implementation HHSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"search";
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    [self locateMapViewInView:self.view frame:rect completion:nil];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"push"
                                    style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(push)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}



- (void)push
{
    
    HHSearchController *vc = [[HHSearchController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}






@end






















