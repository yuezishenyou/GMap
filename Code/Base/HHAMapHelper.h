//
//  HHAMapHelper.h
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHBaseController.h"
//基础定位类
#import <AMapFoundationKit/AMapFoundationKit.h>
//高德地图基础类
#import <MAMapKit/MAMapKit.h>
//搜索基础类
#import <AMapSearchKit/AMapSearchKit.h>
//高德导航类
#import <AMapNaviKit/AMapNaviKit.h>
//gps纠偏类
#import <JZLocationConverter.h>


typedef void(^HYBUserLocationCompletion)(BOOL finish);

@interface HHAMapHelper : HHBaseController

//@property (nonatomic,strong)

@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) AMapSearchAPI *search;

@property (nonatomic,copy) HYBUserLocationCompletion locationCompletion;


- (void)locateMapViewInView:(UIView *)mapSuerView
                      frame:(CGRect)frame
             completion:(HYBUserLocationCompletion)completion;


- (void)viewDidDeallocOrReceiveMemoryWarning;


-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request
                    response:(AMapReGeocodeSearchResponse *)response;






@end
