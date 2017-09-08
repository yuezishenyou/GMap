//
//  HHSunController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSunController.h"
#import "MapManager.h"

@interface HHSunController ()

@end

@implementation HHSunController

- (void)dealloc
{
    NSLog(@"----spring释放------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"夏";
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
