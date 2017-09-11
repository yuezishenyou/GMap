//
//  HHEastController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/11.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHEastController.h"
#import "Global.h"
#import "HHWestController.h"

@interface HHEastController ()<MAMapViewDelegate>

@property (nonatomic,strong)MAMapView *mapView;

@property (nonatomic,strong)UIView *mView;

@end

@implementation HHEastController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"东";
    
    [self initSubViews];
    
    
    
}




- (void)initSubViews
{
    _mView = [[UIView alloc]init];
    _mView.frame = CGRectMake(0, 64, kScreenW, 20);
    _mView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_mView];
    
    
    //
    self.mapView = [Global manager].mapView;
    if (self.mapView == nil) {
        self.mapView = [[MAMapView alloc]init];
        [[Global manager]setMapView:self.mapView];
    }
    self.mapView.frame = [[UIScreen mainScreen]bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"西" style:UIBarButtonItemStyleDone target:self action:@selector(westAction)];
}


- (void)westAction
{
    HHWestController *vc = [[HHWestController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)dealloc
{
    NSLog(@"---eastvc释放--------");
}








@end














