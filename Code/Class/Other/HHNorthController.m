//
//  HHNorthController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/11.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHNorthController.h"
#import "Global.h"
#import "MapManager.h"

@interface HHNorthController ()

@property (nonatomic,strong)MAMapView *mapView;

@property (nonatomic,strong)UIView *mView;

@end

@implementation HHNorthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"北";
    
    [self initSubViews];
    
    
}

- (void)initSubViews
{
    //
    
    MapManager *manager = [MapManager sharedManager];
    
    manager.controller = self;
    
    [manager initMapView];
    
    
    
    
    
//    self.mapView = [Global manager].mapView;
//    [self.view addSubview:self.mapView];
//    [self.view sendSubviewToBack:self.mapView];
//    
//    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"北" style:UIBarButtonItemStyleDone target:self action:@selector(northAction)];
}


- (void)northAction
{
    HHNorthController *vc = [[HHNorthController  alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)dealloc
{
    NSLog(@"----HHNorthController释放------");
}




@end










