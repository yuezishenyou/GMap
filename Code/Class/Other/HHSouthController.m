//
//  HHSouthController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/11.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSouthController.h"
#import "Global.h"
#import "HHNorthController.h"

@interface HHSouthController ()<MAMapViewDelegate>

@property (nonatomic,strong)MAMapView *mapView;

@end

@implementation HHSouthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"南";
    
    [self initSubViews];
    
    
}

- (void)initSubViews
{
    
    Global *manager = [Global manager];
    
    [manager initMapView];
    
    [self.view addSubview:manager.mapView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"北" style:UIBarButtonItemStyleDone target:self action:@selector(northAction)];
}


- (void)northAction
{
    HHNorthController *vc = [[HHNorthController  alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)dealloc
{
    NSLog(@"----HHSouthController释放------");
}




@end











