//
//  MentaSplashViewController.m
//  Menta-Global
//
//  Created by jdy on 2024/5/30.
//

#import "MentaSplashViewController.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface MentaSplashViewController () <MentaMediationSplashDelegate>

@property (nonatomic, strong) MentaMediationSplash *splashAd;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btnShow;

@end

@implementation MentaSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn.frame = CGRectMake(100, 100, 100, 80);
    [self.btn setTitle:@"加载广告" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    self.btnShow = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnShow.frame = CGRectMake(100, 200, 100, 80);
    [self.btnShow setTitle:@"展现广告" forState:UIControlStateNormal];
    [self.btnShow addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnShow];
}

- (void)loadAd {
    
    if (self.splashAd) {
        self.splashAd.delegate = nil;
        self.splashAd = nil;
    }
    
    self.splashAd = [[MentaMediationSplash alloc] initWithPlacementID:@"P0018"];
    self.splashAd.delegate = self;
    
    [self.splashAd loadSplashAd];
}

- (void)showAd {
    if (!self.splashAd.isAdReady) {
        NSLog(@"广告物料未加载成功");
        return;
    }
    
    [self.splashAd showAdInWindow:self.view.window];
}

#pragma mark - MentaMediationSplashDelegate

// 广告素材加载成功
- (void)menta_splashAdDidLoad:(MentaMediationSplash *)splash {
    NSLog(@"%s", __FUNCTION__);
}

// 广告素材加载失败
- (void)menta_splashAdLoadFailedWithError:(NSError *)error splash:(MentaMediationSplash *)splash {
    NSLog(@"%s, %@", __FUNCTION__, error);
}

// 广告素材渲染成功
- (void)menta_splashAdRenderSuccess:(MentaMediationSplash *)splash {
    NSLog(@"%s, price %@", __FUNCTION__, splash.eCPM);
}

// 广告素材渲染失败
- (void)menta_splashAdRenderFailureWithError:(NSError *)error splash:(MentaMediationSplash *)splash {
    NSLog(@"%s, %@", __FUNCTION__, error);
}

// 开屏广告即将展示
- (void)menta_splashAdWillPresent:(MentaMediationSplash *)splash {
    NSLog(@"%s", __FUNCTION__);
}

// 开屏广告展示失败
- (void)menta_splashAdShowFailWithError:(NSError *)error splash:(MentaMediationSplash *)splash {
    NSLog(@"%s", __FUNCTION__);
}

// 开屏广告曝光
- (void)menta_splashAdExposed:(MentaMediationSplash *)splash {
    NSLog(@"%s", __FUNCTION__);
}

// 开屏广告点击
- (void)menta_splashAdClicked:(MentaMediationSplash *)splash {
    NSLog(@"%s", __FUNCTION__);
}

// 开屏广告关闭
-(void)menta_splashAdClosed:(MentaMediationSplash *)splash {
    NSLog(@"%s", __FUNCTION__);
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
