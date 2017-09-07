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

@interface HHMainController ()<PlaceViewDelegate>

@property (nonatomic,strong) PlaceView *placeView;

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

- (void)initSubViews
{
    self.placeView = [PlaceView initView];
    
    self.placeView.frame = CGRectMake(0, 64, kScreenW, 120);
    
    self.placeView.delegate = self;
    
    [self.view addSubview:self.placeView];
    
    
    UIView *view = [[UIView alloc]init];
    
    view.frame = CGRectMake((kScreenW - 2)/2, (kScreenH - 2)/2, 2, 2);
    
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
    
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

-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSString *address = response.regeocode.formattedAddress;
    
    NSLog(@"----address:%@----",address);
}








- (void)dealloc
{
   
}



@end









