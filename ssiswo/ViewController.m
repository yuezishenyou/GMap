//
//  ViewController.m
//  ssiswo
//
//  Created by maoziyue on 17/8/15.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "ViewController.h"
#import "HHMainController.h"
#import "HHNaviController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tbView;

@property (nonatomic,copy)   NSArray *dataArray;

@property (nonatomic,copy)   NSArray *vcArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    
    [self initSubViews];
    
}


- (void)initData
{
    self.dataArray = @[@"主页",@"导航",@"检索",@"Test",@"春",@"夏",@"秋",@"冬",@"东",@"西",@"南",@"北"];
    
    self.vcArray = @[@"HHMainController",
                     @"HHNaviController",
                     @"HHSearchController",
                     @"HHTestController",
                     @"HHSpringController",
                     @"HHSunController",
                     @"HHAutumnController",
                     @"HHWinterController",
                     @"HHEastController",
                     @"HHWestController",
                     @"HHSouthController",
                     @"HHNorthController"
                     ];
}

- (void)initSubViews
{
    
    
    self.tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64)
                                              style:UITableViewStylePlain];
    
    self.tbView.dataSource = self;
    
    self.tbView.delegate = self;
    
    [self.view addSubview:self.tbView];
    
    //self.tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



#pragma  makr ----------- UITableViewDataSource --------------

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
    
}


#pragma mark ------------- UITableViewDelegate -----------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 1) {
        
        HHNaviController *vc = [[HHNaviController alloc]initWithNibName:@"HHNaviController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        NSString *vcStr = self.vcArray[indexPath.row];
        
        Class class = NSClassFromString(vcStr);
        
        UIViewController *vc = [[class alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}




@end

















