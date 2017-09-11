//
//  HHSearchController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHSearchController.h"
#import "HHSearchBar.h"

@interface HHSearchController ()<HHSearchBarDelegate>

@property (nonatomic,strong)HHSearchBar *searchBar;

@end

@implementation HHSearchController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self.mapView sendSubviewToBack:self.view];
    [self.view insertSubview:self.mapView atIndex:0];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"search";
    
    
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    [self locateMapViewInView:self.view frame:rect completion:nil];
    
    [self initSubViews];
   
    
    
}












#pragma mark --HHSearchBarDelegate
- (void)searchKeywords:(NSString *)keywords
{
    NSLog(@"-----关键词:%@------",keywords);
    
    [self searchPOIKeywords:keywords];
}



/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
     NSLog(@"--------搜索回调-------");
    
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSArray *pois = response.pois;
    
    for (AMapPOI *poi in pois)
    {
        NSLog(@"-----点:%@--------",poi.name);
    }
    
    
    
//    [self.mapView removeAnnotations:self.mapView.annotations];
//    
//    if (response.pois.count == 0)
//    {
//        return;
//    }
    
//    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
//    
//    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
//        
//        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
//        
//    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    //[self.mapView addAnnotations:poiAnnotations];
    
//    /* 如果只有一个结果，设置其为中心点. */
//    if (poiAnnotations.count == 1)
//    {
//        [self.mapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
//    }
//    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
//    else
//    {
//        [self.mapView showAnnotations:poiAnnotations animated:NO];
//    }
    

}












- (void)initSubViews
{
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"push"
                                    style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(push)];
    
    //searchBar
    self.searchBar = [[HHSearchBar alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 50)];
    
    self.searchBar.backgroundColor = [UIColor whiteColor];
    
    self.searchBar.delegate = self;
    
    [self.view addSubview:self.searchBar];
    
    //[self.searchBar sendSubviewToBack:self.mapView];

}



- (void)push
{
    
    HHSearchController *vc = [[HHSearchController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}






@end






















