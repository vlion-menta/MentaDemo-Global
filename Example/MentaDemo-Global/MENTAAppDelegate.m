//
//  MENTAAppDelegate.m
//  MentaDemo-Global
//
//  Created by jdy on 06/26/2024.
//  Copyright (c) 2024 jdy. All rights reserved.
//

#import "MENTAAppDelegate.h"
#import "MainViewController.h"
#import <MentaBaseGlobal/MentaBaseGlobal-umbrella.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface MENTAAppDelegate ()

@property (nonatomic, strong) MainViewController *initialVc;
@property (nonatomic, strong) UINavigationController *navVC;

@end

@implementation MENTAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.initialVc = [[MainViewController alloc] init];
    self.navVC = [[UINavigationController alloc] initWithRootViewController:self.initialVc];
    self.window.rootViewController = self.navVC;
    [self.window makeKeyAndVisible];
    
    MentaAdSDK *menta = [MentaAdSDK shared];
    [menta setLogLevel:kMentaLogLevelDebug];
    
    [menta startWithAppID:@"A0004" appKey:@"510cc7cdaabbe7cb975e6f2538bc1e9d" finishBlock:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [[MentaLogger stdLogger] info:@"menta sdk init success"];
        } else {
            [[MentaLogger stdLogger] info:[NSString stringWithFormat:@"menta sdk init failure, %@", error.localizedDescription]];
        }
    }];

    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // ATT 权限获取
    [self getAdvertisingTrackingAuthority];
}

- (void)getAdvertisingTrackingAuthority {
    if (@available(iOS 14, *)) {
        // 在 iOS 14 及更新版本中，使用 App Tracking Transparency 框架请求用户授权
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 在这里处理用户的授权结果
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                    // 用户已授权，可以获取 IDFA
                    [self getIDFA];
                    break;
                case ATTrackingManagerAuthorizationStatusDenied:
                    // 用户拒绝授权，处理相应逻辑
                    break;
                case ATTrackingManagerAuthorizationStatusNotDetermined:
                    // 用户还未作出选择，可以继续等待或提示用户进行授权
                    break;
                case ATTrackingManagerAuthorizationStatusRestricted:
                    // 授权受到限制，可能是由于家长控制等原因
                    break;
            }
        }];
    } else {
        // 在 iOS 14 以下版本，可以直接获取 IDFA
        [self getIDFA];
    }
}

- (void)getIDFA {
    dispatch_async(dispatch_get_main_queue(), ^{
        // do something
        // 获取 IDFA
        NSUUID *IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        NSString *idfaString = [IDFA UUIDString];
        NSLog(@"idfaString : %@", idfaString);
    });

}

@end
