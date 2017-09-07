//
//  PlaceView.h
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceView;
@protocol PlaceViewDelegate <NSObject>

@optional
- (void)placeView:(PlaceView *)placeView onButton:(UIButton *)onBtn;
- (void)placeView:(PlaceView *)placeView offButton:(UIButton *)offBtn;

@end

@interface PlaceView : UIView

+ (instancetype)initView;

@property (weak, nonatomic) IBOutlet UILabel *onLabel;

@property (weak, nonatomic) IBOutlet UILabel *offLabel;
@property (weak, nonatomic) IBOutlet UIButton *onBtn;

@property (weak, nonatomic) IBOutlet UIButton *offBtn;

@property (weak, nonatomic) id<PlaceViewDelegate>delegate;


@end
