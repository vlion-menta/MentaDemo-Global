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
@property (nonatomic, assign) BOOL  isLoded;

//@property (nonatomic, strong) UITextField *placementIDField;
//@property (nonatomic, strong) UITextField *countdownField;

@end

@implementation MentaInterstitialViewController

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
    
//    self.placementIDField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
//    self.placementIDField.placeholder = @"P0291";
//    self.placementIDField.borderStyle = UITextBorderStyleRoundedRect;
//    self.placementIDField.keyboardType = UIKeyboardTypeNumberPad;
//    [self.view addSubview:self.placementIDField];
//    
//    self.countdownField = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 200, 50)];
//    self.countdownField.placeholder = @"enter count down here";
//    self.countdownField.borderStyle = UITextBorderStyleRoundedRect;
//    self.countdownField.keyboardType = UIKeyboardTypeNumberPad;
//    [self.view addSubview:self.countdownField];
}

- (void)loadAd {
    if (self.interstitialAd) {
        self.interstitialAd.delegate = nil;
        self.interstitialAd = nil;
    }
    
    self.interstitialAd = [[MentaMediationInterstitial alloc] initWithPlacementID:@"P0022"];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];

}

- (void)showAd {
    
    if (![self.interstitialAd isAdReady]) {
        NSLog(@"广告物料未加载成功");
        return;
    }
    
    [self.interstitialAd showAdFromRootViewController:self];
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
-(void)menta_interstitialoClosed:(MentaMediationInterstitial *)interstitial {
    NSLog(@"%s", __FUNCTION__);
}

@end
