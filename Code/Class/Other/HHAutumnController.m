//
//  HHAutumnController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHAutumnController.h"
#import "MapManager.h"


@interface HHAutumnController ()

@end

@implementation HHAutumnController

- (void)dealloc
{
    NSLog(@"----Autumn释放------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"秋";
    
    [self initSubViews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MapManager sharedManager].controller = nil;
}

- (void)initSubViews
{
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"秋"
                                    style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(qiuAction)];
    
    
    
    MapManager *manager = [MapManager sharedManager];
    
    manager.controller = self;
    
    [manager initMapView];
    
}

- (void)qiuAction
{
    
    HHAutumnController *vc = [[HHAutumnController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}




@end


























