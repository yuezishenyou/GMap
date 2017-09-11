//
//  MapManager.m
//  SF_GaoDeMAP
//
//  Created by 首牛 on 2017/6/6.
//  Copyright © 2017年 ShouNew.com. All rights reserved.
//

#import "MapManager.h"
#import "SpeechSynthesizer.h"
#import "MoreMenuView.h"

#define RANGEOFRADIUS  (1200)

@interface MapManager()<MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate,AMapNaviWalkViewDelegate,AMapNaviDriveViewDelegate,AMapNaviDriveManagerDelegate,MoreMenuViewDelegate>
@property (nonatomic,strong)NSMutableArray *searchResultArr;
@property (nonatomic, strong) MoreMenuView *moreMenu;//导航页面菜单选项
@end

//static CLLocationCoordinate2D distinateCoor;//目的地坐标
@implementation MapManager

#pragma mark --创建一个单例类对象
+(instancetype)sharedManager{
    static MapManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例对象
        instance = [[MapManager alloc]init];
    });
    return instance;
}









// ----------------------------------------------------------------------------------------
// MARK: - 初始化
// ----------------------------------------------------------------------------------------

-(void)initMapView
{
    [self initSearch];
    
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        //_mapView.delegate = self;
        _mapView.showsScale = NO;
        _mapView.showsCompass = NO;
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    }

//    [self.controller.view addSubview:_mapView];
//    [self.controller.view sendSubviewToBack:_mapView];
    
    //这个可以写外面
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.showsUserLocation = YES;
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    _mapView.distanceFilter = 5.0f;
    
}

#pragma mark serach初始化
-(void)initSearch
{
    if (_search == nil) {
        _search =[[AMapSearchAPI alloc] init];
        //_search.delegate = self;
    }
}


#pragma mark --初始化导航管理类对象
- (void)initDriveManager
{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        self.driveManager.delegate = self;
    }
}






// ----------------------------------------------------------------------------------------
// MARK: - 用户定位
// ----------------------------------------------------------------------------------------

#pragma mark ---------用户定位信息---------

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"------定位用户位置失败------");
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"------lat:%f,lon:%f------",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
    self.currentLocation = [userLocation.location copy];
    
}

- (void)setCurrentLocation:(CLLocation *)currentLocation
{
    if (_currentLocation == nil) {
        _currentLocation = currentLocation;
        
        MACoordinateRegion reg = MACoordinateRegionMakeWithDistance(_mapView.centerCoordinate, RANGEOFRADIUS, RANGEOFRADIUS);
        [_mapView setRegion:reg animated:NO];
        [_mapView setCenterCoordinate:currentLocation.coordinate];
    }
}









// ----------------------------------------------------------------------------------------
// MARK: -
// ----------------------------------------------------------------------------------------

























@end
        
        
        
        
        
        
        
        
        
