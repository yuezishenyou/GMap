//
//  HHSpringController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSpringController.h"
#import "MapManager.h"
#import "HHAutumnController.h"
#import "HHSunController.h"


#define RANGEOFRADIUS  (1200)

@interface HHSpringController ()<MAMapViewDelegate>

@property (nonatomic,strong)MAMapView *mapView;

//当前定位
@property(nonatomic,strong)CLLocation *currentLocation;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

@property (nonatomic,strong)UIButton *gpsBtn;
@property (nonatomic,strong)UIButton *jumpBtn;




@end

@implementation HHSpringController

- (void)dealloc
{
    NSLog(@"----spring释放------");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initMap];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self clear];
    
    [MapManager sharedManager].controller = nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"春 mapmanager";
    
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"秋"
                                    style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(qiuAction)];
    
    [self initMap];
    
    [self initgpsBtn];
    
    
    [self initJumpBtn];
    
    

    
    
}



//***************** mapView ***********************/

- (void)addAnnomation
{

    MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc]init];
    
    pointAnnotation1.coordinate = CLLocationCoordinate2DMake(31.231134, 121.365845);
    
    [self.mapView addAnnotation:pointAnnotation1];
    
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc]init];
    
    pointAnnotation2.coordinate = CLLocationCoordinate2DMake(31.230134, 121.366845);
    
    [self.mapView addAnnotation:pointAnnotation2];
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {//定位点
        static NSString *transparentuserLocationStyleReuseIndetifier = @"asuserLocationStyleReuseIndetifier1";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:transparentuserLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:transparentuserLocationStyleReuseIndetifier];

            annotationView.image = [UIImage imageNamed:@"userPosition"];
             self.userLocationAnnotationView = annotationView;
            annotationView.zIndex = 1;
        }
        
        return annotationView;
    }
    
    return nil;
}


- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor clearColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:220.f/250 green:220.f/250 blue:220.f/250 alpha:0];
        
        return accuracyCircleRenderer;
    }
    
    return nil;
}









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
    
    
    if (!updatingLocation && self.userLocationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
    
}

- (void)setCurrentLocation:(CLLocation *)currentLocation
{
    if (_currentLocation == nil ) {
        _currentLocation = currentLocation;
        
        MACoordinateRegion reg = MACoordinateRegionMakeWithDistance(_mapView.centerCoordinate, RANGEOFRADIUS, RANGEOFRADIUS);
        [_mapView setRegion:reg animated:NO];
        [_mapView setCenterCoordinate:currentLocation.coordinate];
    }
}





- (void)clear
{
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
}




























- (void)gpsAction
{
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location)
    {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [self.gpsBtn setSelected:YES];
    }
}
















- (void)initJumpBtn
{
    //订车按钮
    self.jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.jumpBtn.frame = CGRectMake(0, kScreenH - 50, kScreenW, 50);
    
    self.jumpBtn.backgroundColor = [UIColor blackColor];
    
    [self.jumpBtn setTitle:@"实时" forState:UIControlStateNormal];
    
    [self.jumpBtn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.jumpBtn];
}

- (void)jumpAction
{
    HHSunController *vc = [[HHSunController alloc]init];
    
    [self.navigationController pushViewController:vc animated:NO];
}


- (void)initgpsBtn
{
    
    //gps
    self.gpsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.gpsBtn.frame = CGRectMake(20, kScreenH - 180, 40, 40);
    
    self.gpsBtn.layer.cornerRadius = 4.0;
    
    self.gpsBtn.backgroundColor = [UIColor whiteColor];
    
    [self.gpsBtn setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    
    [self.gpsBtn addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gpsBtn];
}




- (void)initMap
{
    MapManager *manager = [MapManager sharedManager];
    
    [manager initMapView];
    
    self.mapView = manager.mapView;
    
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    self.mapView.delegate = self;
}


- (void)qiuAction
{
    HHAutumnController *vc = [[HHAutumnController alloc]init];
    
    [self.navigationController pushViewController:vc animated:NO];
}












@end
















