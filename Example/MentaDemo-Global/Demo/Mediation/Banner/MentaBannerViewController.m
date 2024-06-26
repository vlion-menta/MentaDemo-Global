//
//  MentaBannerViewController.m
//  Menta-Global
//
//  Created by jdy on 2024/6/25.
//

#import "MentaBannerViewController.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface MentaBannerViewController () <MentaMediationBannerDelegate>

@property (nonatomic, strong) MentaMediationBanner *bannerAd;
@property (nonatomic, strong) UIView *bannerView;

@property (nonatomic, strong) UIButton *btnLoad;
@property (nonatomic, strong) UIButton *btnShow;

@end

@implementation MentaBannerViewController

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
}

- (void)loadAd {
    if (self.bannerAd) {
        self.bannerAd.delegate = nil;
        self.bannerAd = nil;
        self.view.backgroundColor = [UIColor whiteColor];
        [self.bannerView removeFromSuperview];
    }
    self.bannerAd = [[MentaMediationBanner alloc] initWithPlacementID:@"P0026"];
    self.bannerAd.delegate = self;
    
    [self.bannerAd loadAd];
}

- (void)showAd {
    if (self.bannerView && [self.bannerAd isAdReady]) {
        self.view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:self.bannerView];
        
        [self.bannerView mas_makeConstraints:^(MentaMASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.centerX.equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(CGRectGetWidth(self.bannerView.bounds));
            make.height.mas_equalTo(CGRectGetHeight(self.bannerView.bounds));
        }];
    }
}

#pragma mark - MentaMediationBannerDelegate

// 广告素材加载成功
- (void)menta_bannerAdDidLoad:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
}

// 广告素材加载失败
- (void)menta_bannerAdLoadFailedWithError:(NSError *)error banner:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    NSLog(@"%@", error);
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_bannerAdRenderSuccess:(MentaMediationBanner *)banner bannerAdView:(UIView *)bannerAdView {
    NSLog(@"%s", __func__);
    self.bannerView = bannerAdView;
}

// 广告素材渲染失败
- (void)menta_bannerAdRenderFailureWithError:(NSError *)error banner:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    NSLog(@"%@", error);
}

// 广告曝光
- (void)menta_bannerAdExposed:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
}

// 广告点击
- (void)menta_bannerAdClicked:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
}

// 广告关闭
-(void)menta_bannerAdClosed:(MentaMediationBanner *)banner {
    NSLog(@"%s", __func__);
    self.bannerView = nil;
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
