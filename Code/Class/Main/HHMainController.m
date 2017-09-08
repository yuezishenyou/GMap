//
//  HHMainController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMainController.h"
#import "MapManager.h"
#import "HHSearchController.h"
#import "PlaceView.h"
#import "HHSearchController.h"
#import "HHRealtimeController.h"

@interface HHMainController ()<PlaceViewDelegate>

@property (nonatomic,strong) PlaceView *placeView;

@property (nonatomic,strong) UIButton *gpsBtn;

@property (nonatomic,strong) UIButton *jumpBtn;

@end

@implementation HHMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = [[UIScreen mainScreen]bounds];
    
    [self locateMapViewInView:self.view frame:frame completion:nil];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"search"
                                    style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(rightAction)];
    
    [self addAnnomation];
    
    [self initSubViews];
    
}


#pragma mark --mapView

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    CGPoint point = CGPointMake(kScreenW / 2, kScreenH / 2);
    
    CLLocationCoordinate2D randomCoordinate =  [self.mapView convertPoint:point toCoordinateFromView:self.supView];
    [self searchReGeocodeWithCoordinate:randomCoordinate];
}


-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSString *address = response.regeocode.formattedAddress;
    
    NSLog(@"----address:%@----",address);
    
    self.placeView.onLabel.text = address;
}





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
    NSLog(@"viewForAnnotation");
    return nil;
}

- (void)gpsAction
{
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location)
    {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [self.gpsBtn setSelected:YES];
    }
}






















- (void)initSubViews
{
    //上车点
    self.placeView = [PlaceView initView];
    
    self.placeView.frame = CGRectMake(0, 64, kScreenW, 120);
    
    self.placeView.delegate = self;
    
    [self.view addSubview:self.placeView];
    
    
    //中心点
    UIView *view = [[UIView alloc]init];
    
    view.frame = CGRectMake((kScreenW - 5)/2, (kScreenH - 5)/2, 5, 5);
    
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
    
    //gps
    self.gpsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.gpsBtn.frame = CGRectMake(20, kScreenH - 180, 40, 40);
    
    self.gpsBtn.layer.cornerRadius = 4.0;
    
    self.gpsBtn.backgroundColor = [UIColor whiteColor];
    
    [self.gpsBtn setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    
    [self.gpsBtn addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.gpsBtn];
    
    
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
    
    HHRealtimeController *vc = [[HHRealtimeController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}






- (void)rightAction
{
    
    HHSearchController *vc = [[HHSearchController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark --PlaceViewDelegate
- (void)placeView:(PlaceView *)placeView offButton:(UIButton *)offBtn
{
    HHSearchController *searchvc = [[HHSearchController alloc]init];
    
    [self.navigationController pushViewController:searchvc animated:YES];
}

- (void)placeView:(PlaceView *)placeView onButton:(UIButton *)onBtn
{
    HHSearchController *searchvc = [[HHSearchController alloc]init];
    
    [self.navigationController pushViewController:searchvc animated:YES];
}









- (void)dealloc
{
   
}



@end









