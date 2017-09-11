//
//  HHWinterController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHWinterController.h"
#import "MapManager.h"

@interface HHWinterController ()

@end

@implementation HHWinterController

- (void)dealloc
{
    NSLog(@"----winter释放------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MapManager sharedManager].controller = nil;
}



- (void)initSubViews
{
    MapManager *manager = [MapManager sharedManager];
    
    manager.controller = self;
    
    [manager initMapView];
    
}










@end












