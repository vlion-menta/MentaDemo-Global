//
//  MentaNativeExpressViewController.m
//  Menta-Global
//
//  Created by jdy on 2024/6/25.
//

#import "MentaNativeExpressViewController.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface MentaNativeExpressViewController () <MentaMediationNativeExpressDelegate>

@property (nonatomic, strong) UIButton *btnLoad;
@property (nonatomic, strong) UIButton *btnShow;

@property (nonatomic, strong) MentaMediationNativeExpress *nativeAd;
@property (nonatomic, strong) UIView *nativeAdView; // adView

@end

@implementation MentaNativeExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.btnLoad = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnLoad.frame = CGRectMake(100, 100, 100, 80);
    [self.btnLoad setTitle:@"加载广告" forState:UIControlStateNormal];
    [self.btnLoad addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnLoad];
    
    self.btnShow = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnShow.frame = CGRectMake(100, 200, 100, 80);
    [self.btnShow setTitle:@"展现广告" forState:UIControlStateNormal];
    [self.btnShow addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnShow];

    [self loadAd];
}

- (void)loadAd {
    if (self.nativeAd) {
        self.nativeAd.delegate = nil;
        self.nativeAd = nil;
        self.view.backgroundColor = [UIColor whiteColor];
        [self.nativeAdView removeFromSuperview];
    }

    if (!self.view.window.rootViewController) {
        return;
    }
    
    self.nativeAd = [[MentaMediationNativeExpress alloc] initWithPlacementID:@"P0027"];
    self.nativeAd.delegate = self;
    
    [self.nativeAd loadAd];

}

- (void)showAd {
    if (!self.nativeAd.isAdReady) {
        NSLog(@"请先加载广告");
        return;
    }
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.nativeAdView];
    
    [self.nativeAdView mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(CGRectGetWidth(self.nativeAdView.bounds));
        make.height.mas_equalTo(CGRectGetHeight(self.nativeAdView.bounds));
    }];
}

#pragma mark - MentaMediationNativeExpressDelegate

// 广告素材加载成功
- (void)menta_nativeExpressAdDidLoad:(MentaMediationNativeExpress *)nativeExpress {
    NSLog(@"%s", __func__);
}

// 广告素材加载失败
- (void)menta_nativeExpressAdLoadFailedWithError:(NSError *)error nativeExpress:(MentaMediationNativeExpress *)nativeExpress {
    NSLog(@"%s", __func__);
    NSLog(@"%@", error);
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_nativeExpressAdRenderSuccess:(MentaMediationNativeExpress *)nativeExpress nativeExpressView:(UIView *)nativeExpressView {
    NSLog(@"%s", __func__);
    self.nativeAdView = nativeExpressView;
}

// 广告素材渲染失败
- (void)menta_nativeExpressAdRenderFailureWithError:(NSError *)error nativeExpress:(MentaMediationNativeExpress *)nativeExpress {
    NSLog(@"%s", __func__);
    NSLog(@"%@", error);
}

// 广告曝光
- (void)menta_nativeExpressAdExposed:(MentaMediationNativeExpress *)nativeExpress {
    NSLog(@"%s", __func__);
}

// 广告点击
- (void)menta_nativeExpressrAdClicked:(MentaMediationNativeExpress *)nativeExpress {
    NSLog(@"%s", __func__);
}

// 广告关闭
-(void)menta_nativeExpressAdClosed:(MentaMediationNativeExpress *)nativeExpress {
    NSLog(@"%s", __func__);
    self.view.backgroundColor = [UIColor whiteColor];
    self.nativeAdView = nil;
}


@end
