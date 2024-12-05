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
@property (nonatomic, strong) UIButton *btnLoss;
@property (nonatomic, strong) UITextField *placementIDField;

@property (nonatomic, strong) MentaMediationNativeExpress *nativeAd;
@property (nonatomic, strong) UIView *nativeAdView; // adView

@end

@implementation MentaNativeExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 40;
    CGFloat centerX = self.view.frame.size.width / 2 - buttonWidth / 2;
    
    self.btnLoad = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnLoad.frame = CGRectMake(centerX, 150, buttonWidth, buttonHeight);
    [self.btnLoad setTitle:@"加载广告" forState:UIControlStateNormal];
    [self.btnLoad setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnLoad.backgroundColor = [UIColor blackColor];
    self.btnLoad.layer.cornerRadius = 5;
    [self.btnLoad addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnLoad];
    
    self.btnShow = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnShow.frame = CGRectMake(centerX, 200, buttonWidth, buttonHeight);
    [self.btnShow setTitle:@"展现广告" forState:UIControlStateNormal];
    [self.btnShow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnShow addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    self.btnShow.backgroundColor = [UIColor blackColor];
    self.btnShow.layer.cornerRadius = 5;
    [self.view addSubview:self.btnShow];
    
    self.btnLoss = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnLoss.frame = CGRectMake(centerX, 250, buttonWidth, buttonHeight);
    [self.btnLoss setTitle:@"send bid fail" forState:UIControlStateNormal];
    [self.btnLoss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnLoss addTarget:self action:@selector(sendLossNotification) forControlEvents:UIControlEventTouchUpInside];
    self.btnLoss.backgroundColor = [UIColor blackColor];
    self.btnLoss.layer.cornerRadius = 5;
    [self.view addSubview:self.btnLoss];
    
    self.placementIDField = [[UITextField alloc] initWithFrame:CGRectMake(centerX, 300, buttonWidth, buttonHeight)];
    self.placementIDField.placeholder = @"P0027";
    self.placementIDField.borderStyle = UITextBorderStyleNone;
    self.placementIDField.layer.borderColor = [UIColor blackColor].CGColor;
    self.placementIDField.layer.borderWidth = 2.0;
    self.placementIDField.layer.cornerRadius = 5.0;
    self.placementIDField.keyboardType = UIKeyboardTypeNumberPad;
    self.placementIDField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.placementIDField];

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
    
    NSString *placementID = self.placementIDField.text;
    if (!placementID || placementID.length == 0) {
        placementID = @"P0028";
    }
    
    self.nativeAd = [[MentaMediationNativeExpress alloc] initWithPlacementID:placementID];
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
    [self.nativeAd sendWinnerNotificationWith:nil];
    
    [self.nativeAdView mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(CGRectGetWidth(self.nativeAdView.bounds));
        make.height.mas_equalTo(CGRectGetHeight(self.nativeAdView.bounds));
    }];
}

- (void)sendLossNotification {
    [self.nativeAd sendLossNotificationWithWinnerPrice:@"" info:@{@"loss_reason": @"101"}];
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
