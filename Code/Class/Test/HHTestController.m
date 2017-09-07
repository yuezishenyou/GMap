//
//  HHTestController.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHTestController.h"
#import "MapManager.h"

@interface HHTestController ()

@end

@implementation HHTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"test";
    
    [self locateMapViewInView:self.view frame:[[UIScreen mainScreen]bounds] completion:nil];
    
    
    
    [self addAnnotation];

}


- (void)addAnnotation
{
    
    MAPointAnnotation *pointAnnotaion = [[MAPointAnnotation alloc]init];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.232134, 121.365545);
    
    pointAnnotaion.coordinate = coordinate;
    
    [self.mapView addAnnotation:pointAnnotaion];
    
}

































- (void)dealloc
{
    //[self viewDidDeallocOrReceiveMemoryWarning];
    //NSLog(@"----testvc释放-----");
}




@end
