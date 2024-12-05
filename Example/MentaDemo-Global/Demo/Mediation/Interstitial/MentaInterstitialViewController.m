//
//  MentaInterstitialViewController.m
//  Menta-Global
//
//  Created by jdy on 2024/6/24.
//

#import "MentaInterstitialViewController.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface MentaInterstitialViewController () <MentaMediationInterstitialDelegate>

@property (nonatomic, strong) MentaMediationInterstitial *interstitialAd;
@property (nonatomic, strong) UIButton *btnLoad;
@property (nonatomic, strong) UIButton *btnShow;
@property (nonatomic, strong) UIButton *btnLoss;
@property (nonatomic, assign) BOOL  isLoded;

@property (nonatomic, strong) UITextField *placementIDField;

@end

@implementation MentaInterstitialViewController

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
    self.placementIDField.placeholder = @"P0022";
    self.placementIDField.borderStyle = UITextBorderStyleNone;
    self.placementIDField.layer.borderColor = [UIColor blackColor].CGColor;
    self.placementIDField.layer.borderWidth = 2.0;
    self.placementIDField.layer.cornerRadius = 5.0;
    self.placementIDField.keyboardType = UIKeyboardTypeNumberPad;
    self.placementIDField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.placementIDField];
}

- (void)loadAd {
    if (self.interstitialAd) {
        self.interstitialAd.delegate = nil;
        self.interstitialAd = nil;
    }
    
    NSString *placementID = self.placementIDField.text;
    if (!placementID || placementID.length == 0) {
        placementID = @"P0023";
//        placementID = @"P0025"; // web
    }
    
    self.interstitialAd = [[MentaMediationInterstitial alloc] initWithPlacementID:placementID];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];

}

- (void)showAd {
    
    if (![self.interstitialAd isAdReady]) {
        NSLog(@"广告物料未加载成功");
        return;
    }
    
    [self.interstitialAd sendWinnerNotificationWith:nil];
    [self.interstitialAd showAdFromRootViewController:self];
}

- (void)sendLossNotification {
    [self.interstitialAd sendLossNotificationWithWinnerPrice:@"" info:@{@"loss_reason": @"101"}];
}

// 广告素材加载成功
- (void)menta_interstitialDidLoad:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

// 广告素材加载失败
- (void)menta_interstitialLoadFailedWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", error);
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_interstitialRenderSuccess:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

// 广告素材渲染失败
- (void)menta_interstitialRenderFailureWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", error);
}

// 广告即将展示
- (void)menta_interstitialWillPresent:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

// 广告展示失败
- (void)menta_interstitialShowFailWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

// 广告曝光
- (void)menta_interstitialExposed:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

// 广告点击
- (void)menta_interstitialClicked:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

// 视频播放完成
- (void)menta_interstitialPlayCompleted:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

// 广告关闭
-(void)menta_interstitialClosed:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

@end
