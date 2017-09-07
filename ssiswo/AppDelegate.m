//
//  AppDelegate.m
//  ssiswo
//
//  Created by maoziyue on 17/8/15.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [AMapServices sharedServices].apiKey = MapKey;
    [AMapServices sharedServices].enableHTTPS = YES;
    
    
    
    
    self.window.frame = [[UIScreen mainScreen]bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *vc = [[ViewController alloc]init];
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = navc;
    
    [self.window makeKeyAndVisible];
    
    

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
 
}


@end
