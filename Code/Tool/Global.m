//
//  Global.m
//  ssiswo
//
//  Created by maoziyue on 2017/9/7.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (instancetype)manager
{
    static Global *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[Global alloc]init];
        }
    });
    return _manager;
}


- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}



//******************* methods *******************／






















@end
