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






















