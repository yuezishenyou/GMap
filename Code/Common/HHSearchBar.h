//
//  HHSearchBar.h
//  HH_自定搜索框
//
//  Created by maoziyue on 17/6/14.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HHSearchBarDelegate <NSObject>
@optional
- (void)searchKeywords:(NSString *)keywords;


@end


@interface HHSearchBar : UIView

@property (nonatomic,strong)UITextField *searchTextField;
@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,weak) id<HHSearchBarDelegate> delegate;

@end
