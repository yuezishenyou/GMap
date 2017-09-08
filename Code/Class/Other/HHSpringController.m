//
//  HHSpringController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSpringController.h"
#import "MapManager.h"

@interface HHSpringController ()

@end

@implementation HHSpringController

- (void)dealloc
{
    NSLog(@"----spring释放------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"春";
    
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
















