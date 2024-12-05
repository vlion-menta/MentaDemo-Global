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
@property (nonatomic, strong) UIButton *btnLoss;
@property (nonatomic, strong) UITextField *placementIDField;

@end

@implementation MentaBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 40;
    CGFloat centerX = self.view.frame.size.width / 2 - buttonWidth / 2;
    
    self.btnLoad = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnLoad.frame = CGRectMake(centerX, 100, buttonWidth, buttonHeight);
    [self.btnLoad setTitle:@"加载广告" forState:UIControlStateNormal];
    [self.btnLoad setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnLoad addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    self.btnLoad.backgroundColor = [UIColor blackColor];
    self.btnLoad.layer.cornerRadius = 5;
    [self.view addSubview:self.btnLoad];
    
    self.btnShow = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnShow.frame = CGRectMake(centerX, 150, buttonWidth, buttonHeight);
    [self.btnShow setTitle:@"展现广告" forState:UIControlStateNormal];
    [self.btnShow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnShow addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    self.btnShow.backgroundColor = [UIColor blackColor];
    self.btnShow.layer.cornerRadius = 5;
    [self.view addSubview:self.btnShow];
    
    self.btnLoss = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnLoss.frame = CGRectMake(centerX, 200, buttonWidth, buttonHeight);
    [self.btnLoss setTitle:@"send bid fail" forState:UIControlStateNormal];
    [self.btnLoss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnLoss addTarget:self action:@selector(sendLossNotification) forControlEvents:UIControlEventTouchUpInside];
    self.btnLoss.backgroundColor = [UIColor blackColor];
    self.btnLoss.layer.cornerRadius = 5;
    [self.view addSubview:self.btnLoss];
    
    self.placementIDField = [[UITextField alloc] initWithFrame:CGRectMake(centerX, 250, buttonWidth, buttonHeight)];
    self.placementIDField.placeholder = @"P0026";
    self.placementIDField.borderStyle = UITextBorderStyleNone;
    self.placementIDField.layer.borderColor = [UIColor blackColor].CGColor;
    self.placementIDField.layer.borderWidth = 2.0;
    self.placementIDField.layer.cornerRadius = 5.0;
    self.placementIDField.keyboardType = UIKeyboardTypeNumberPad;
    self.placementIDField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.placementIDField];
}

- (void)loadAd {
    if (self.bannerAd) {
        self.bannerAd.delegate = nil;
        self.bannerAd = nil;
        self.view.backgroundColor = [UIColor whiteColor];
        [self.bannerView removeFromSuperview];
    }
    
    NSString *placementID = self.placementIDField.text;
    if (!placementID || placementID.length == 0) {
        placementID = @"P0026"; // img
//        placementID = @"P0025"; // web
    }
    self.bannerAd = [[MentaMediationBanner alloc] initWithPlacementID:placementID];
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
        
        [self.bannerAd sendWinnerNotificationWith:nil];
    }
}

- (void)sendLossNotification {
    [self.bannerAd sendLossNotificationWithWinnerPrice:@"" info:@{@"loss_reason": @"101"}];
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
