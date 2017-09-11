//
//  HHWestController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/11.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHWestController.h"
#import "Global.h"

@interface HHWestController ()<MAMapViewDelegate>

@property (nonatomic,strong)MAMapView *mapView;

@end

@implementation HHWestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"西";
    
    [self initSubViews];


}


- (void)initSubViews
{
    
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"西" style:UIBarButtonItemStyleDone target:self action:@selector(westAction)];
    
    self.mapView = [Global manager].mapView;
    if (self.mapView == nil) {
        self.mapView = [[MAMapView alloc]init];
        [[Global manager]setMapView:self.mapView];
    }
    self.mapView.frame = [[UIScreen mainScreen]bounds];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
}



- (void)westAction
{
    HHWestController *vc = [[HHWestController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)dealloc
{
    
    self.mapView.delegate = nil;
    [Global manager].mapView = nil;
    self.mapView = nil;
    
    [self.mapView removeFromSuperview];
    NSLog(@"---west释放--------");
}


@end












