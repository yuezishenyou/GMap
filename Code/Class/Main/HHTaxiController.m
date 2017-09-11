//
//  HHTaxiController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHTaxiController.h"
//#import "RouteDetailViewController.h"
#import "CommonUtility.h"
#import "MANaviRoute.h"
static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 20;

@interface HHTaxiController ()

@property (nonatomic, strong) AMapRoute *route;

/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;
/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;

@property (nonatomic, strong) UIBarButtonItem *previousItem;
@property (nonatomic, strong) UIBarButtonItem *nextItem;

/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;


@end

@implementation HHTaxiController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"乘车";

    
    self.startCoordinate        = CLLocationCoordinate2DMake(31.196453, 121.289599);
    self.destinationCoordinate  = CLLocationCoordinate2DMake(31.231134, 121.365845);
    
    [self locateMapViewInView:self.view frame:self.view.frame completion:nil];
    
    [self addDefaultAnnotations];
    
    [self searchDriveRouteWithStartCoordinate:self.startCoordinate
                        destinationCoordinate:self.destinationCoordinate];
    
    [self initSubViews];
    
}




- (void)addDefaultAnnotations
{
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = (NSString*)RoutePlanningViewControllerStartTitle;
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    self.startAnnotation = startAnnotation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];
    self.destinationAnnotation = destinationAnnotation;
    
    [self.mapView addAnnotation:startAnnotation];
    
    [self.mapView addAnnotation:destinationAnnotation];
    
}



#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"------Error:%@----", error);
}

/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    
    NSLog(@"-------onRouteSearchDone-------");
    
    self.route = response.route;
    
    NSArray *array = self.route.paths;
    
    if (array.count)
    {
        [self presentCurrentCourse];
    }
}


/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    
    MANaviAnnotationType type = MANaviAnnotationTypeDrive;
    
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse]
                                      withNaviType:type
                                       showTraffic:YES
                                        startPoint:[AMapGeoPoint
                                                    locationWithLatitude:self.startAnnotation.coordinate.latitude
                                                    longitude:self.startAnnotation.coordinate.longitude]
                                          endPoint:[AMapGeoPoint
                                                    locationWithLatitude:self.destinationAnnotation.coordinate.latitude
                                                    longitude:self.destinationAnnotation.coordinate.longitude]];
    
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
    
}

/* 清空地图上已有的路线. */
- (void)clear
{
    [self.naviRoute removeFromMapView];
}




#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{

    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        
        [polylineRenderer loadStrokeTextureImage:[UIImage imageNamed:@"arrowTexture"]];
        
        return polylineRenderer;
        
    }

    return nil;
}



















- (void)initSubViews
{
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"返回主页"
                                    style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(backMain)];
}

- (void)backMain
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

















@end

















