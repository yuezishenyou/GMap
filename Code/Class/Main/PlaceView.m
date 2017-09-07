//
//  PlaceView.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "PlaceView.h"



@implementation PlaceView

+ (instancetype)initView
{
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"PlaceView" owner:nil options:nil];
    return [array firstObject];
}

- (IBAction)onBtnAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(placeView:onButton:)]) {
        [_delegate placeView:self onButton:sender];
    }
    
}

- (IBAction)offBtnAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(placeView:offButton:)]) {
        [_delegate placeView:self offButton:sender];
    }
    
}





@end
