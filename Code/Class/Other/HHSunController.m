//
//  HHSunController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSunController.h"
#import "MapManager.h"

@interface HHSunController ()<MAMapViewDelegate>

@property (nonatomic,strong)MAMapView *mapView;

@end

@implementation HHSunController

- (void)dealloc
{
    NSLog(@"----sun释放------");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"夏";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"夏" style:UIBarButtonItemStyleDone target:self action:@selector(pushSun)];
    
    [self setupMap];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MapManager sharedManager].controller = nil;
}

- (void)setupMap
{
    MapManager *manager = [MapManager sharedManager];
    
    [manager initMapView];
    
    self.mapView = manager.mapView;
    
    [self.view addSubview:self.mapView];
    
    [self.view sendSubviewToBack:self.mapView];
    
    self.mapView.delegate = self;
    
}











#pragma mark --UI
- (void)pushSun
{
    HHSunController *vc = [[HHSunController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}




@end
