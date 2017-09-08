//
//  HHRealtimeController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHRealtimeController.h"
#import "HHTaxiController.h"
#import "HHTaxiController.h"

@interface HHRealtimeController ()

@end

@implementation HHRealtimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"叫单";
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    [self locateMapViewInView:self.view frame:rect completion:nil];
    
    self.mapView.showsUserLocation = NO;
    
    [self initSubViews];
    
}


- (void)initSubViews
{
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"乘车界面"
                                    style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(taxiAction)];
    
}

- (void)taxiAction
{
    
    HHTaxiController *vc = [[HHTaxiController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
