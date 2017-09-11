//
//  Global.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (instancetype)manager
{
    static Global *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[Global alloc]init];
        }
    });
    return _manager;
}


- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    //self.mapView = [[MAMapView alloc]init];
    //self.mapView.frame = [[UIScreen mainScreen]bounds];
}





//******************* methods *******************／

- (void)initMapView
{
    if (self.mapView == nil) {
        self.mapView = [[MAMapView alloc]init];
        
    }
    self.mapView.frame = [[UIScreen mainScreen]bounds];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    //设置地图缩放比例，即显示区域
    [self.mapView setZoomLevel:15.1 animated:YES];
    //设置定位精度
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    //设置定位距离
    self.mapView.distanceFilter = 5.0f;
}



- (void)setMapView:(MAMapView *)mapView
{
    _mapView = mapView;
    NSLog(@"----map-----");
}



















@end
