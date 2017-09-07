//
//  HHAMapHelper.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHAMapHelper.h"

#define RANGEOFRADIUS  (1000)

@interface HHAMapHelper ()<MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate,AMapNaviWalkViewDelegate,AMapNaviDriveViewDelegate,AMapNaviDriveManagerDelegate>

@property (nonatomic,strong)CLLocation *currentLocation;

@property (nonatomic,strong)UIView *supView;

@end

@implementation HHAMapHelper

+ (instancetype)manager
{
    static HHAMapHelper *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[HHAMapHelper alloc]init];
        }
    });
    return _manager;
}

- (void)locateMapViewInView:(UIView *)mapSuerView frame:(CGRect)frame completion:(HYBUserLocationCompletion)completion
{
    _locationCompletion = [completion copy];
    
    [self initSearch];
    
    
    if (_mapView) {
        [_mapView removeFromSuperview];
        _mapView = nil;
    }
    
    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
    
    _mapView = [[MAMapView alloc]initWithFrame:frame];
    [mapSuerView addSubview:_mapView];
    [_mapView sendSubviewToBack:mapSuerView];
    _mapView.delegate = self;
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.showsUserLocation = YES;
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    _mapView.distanceFilter = 5.0f;
    
    self.supView = mapSuerView;
    
    if (_locationCompletion) {
        _locationCompletion(YES);
    }
    
}

- (BOOL)initSearch
{
    if (_search) {
        _search = nil;
    }
    
    _search.delegate = nil;
    
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
    return YES;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _mapView.delegate = self;
    _search.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _mapView.delegate = nil;
    _search.delegate = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)viewDidDeallocOrReceiveMemoryWarning
{
    _mapView.showsUserLocation = NO;
    _mapView.delegate = nil;
    [_mapView removeFromSuperview];
    _mapView = nil;
    
    _search.delegate = nil;
    _search = nil;
}

- (void)dealloc
{
    [self viewDidDeallocOrReceiveMemoryWarning];
    NSLog(@"------help释放-------");
}



#pragma mark --viewForAnnotation

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {//定位点
        NSLog(@"---------插针1-------------");
        
        static NSString *transparentuserLocationStyleReuseIndetifier = @"asuserLocationStyleReuseIndetifier1";
        
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:transparentuserLocationStyleReuseIndetifier];
        
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:transparentuserLocationStyleReuseIndetifier];
            UIImage *userLocation;
            userLocation = [UIImage imageNamed:@"now_adr"];
            annotationView.image = userLocation;
            annotationView.zIndex = 1;
        }
        return annotationView;
    }

    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        NSLog(@"---------插针2-------------");
        
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor                     = MAPinAnnotationColorRed;
        return annotationView;
    }

    
    
    return nil;
}

#pragma mark didUpdateUserLocation
// 定位用户位置失败
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"------定位用户位置失败------");
}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //NSLog(@"------lat:%f,lon:%f------",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
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

#pragma mark 搜索请求发起后的回调,用于标记自己当前的位置
-(void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"request: %@------error:  %@",request,error);
}

-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    //我们把编码后的地理位置，显示到 大头针的标题和子标题上
    NSString *title = response.regeocode.addressComponent.city;
    NSLog(@"----%@-----",title);
    
//    if (title.length == 0)
//    {
//        title = response.regeocode.addressComponent.province;
//    }
//    
//    if (request.location.latitude == _currentLocation.coordinate.latitude&&request.location.longitude == _currentLocation.coordinate.longitude) {
//        _mapView.userLocation.title = title;
//        _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
//    }
//    else
//    {
//        _destinatePoint.title = title;
//        _destinatePoint.subtitle = response.regeocode.formattedAddress;
//    }
}




#pragma mark --地图移动结束
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    //self.mapView convertPoint:<#(CGPoint)#> toCoordinateFromView:<#(UIView *)#>
    NSLog(@"------地图移动结束------");
}


- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"------地图区域改变------");
    
    CGPoint point = CGPointMake(kScreenW / 2, kScreenH / 2);
    
    CLLocationCoordinate2D randomCoordinate =  [self.mapView convertPoint:point toCoordinateFromView:self.supView];
    
    [self searchReGeocodeWithCoordinate:randomCoordinate];
}





#pragma mark ----------------- Util ------------------------
#pragma mark -
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    regeo.radius = 10000;
    
    [self.search AMapReGoecodeSearch:regeo];//逆地理编码查询 onReGeocodeSearchDone
}















@end















