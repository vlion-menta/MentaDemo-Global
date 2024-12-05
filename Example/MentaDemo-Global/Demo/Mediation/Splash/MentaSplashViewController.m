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
@property (nonatomic, strong) UIButton *btnLoss;
@property (nonatomic, strong) UIButton *btnShow;
@property (nonatomic, strong) UITextField *placementIDField;

@end

@implementation MentaSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 40;
    CGFloat centerX = self.view.frame.size.width / 2 - buttonWidth / 2;
    
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn.frame = CGRectMake(centerX, 100, buttonWidth, buttonHeight);
    [self.btn setTitle:@"加载广告" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
    self.btn.backgroundColor = [UIColor blackColor];
    self.btn.layer.cornerRadius = 5;
    [self.view addSubview:self.btn];
    
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
    self.placementIDField.placeholder = @"P0018";
    self.placementIDField.borderStyle = UITextBorderStyleNone;
    self.placementIDField.layer.borderColor = [UIColor blackColor].CGColor;
    self.placementIDField.layer.borderWidth = 2.0;
    self.placementIDField.layer.cornerRadius = 5.0;
    self.placementIDField.keyboardType = UIKeyboardTypeNumberPad;
    self.placementIDField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.placementIDField];
}

- (void)loadAd {
    
    if (self.splashAd) {
        self.splashAd.delegate = nil;
        self.splashAd = nil;
    }
    
    NSString *placementID = self.placementIDField.text;
    if (!placementID || placementID.length == 0) {
        placementID = @"P0018";
//        placementID = @"P0017"; // web
    }
    
    self.splashAd = [[MentaMediationSplash alloc] initWithPlacementID:placementID];
    self.splashAd.delegate = self;
    
    [self.splashAd loadSplashAd];
}

- (void)showAd {
    if (!self.splashAd.isAdReady) {
        NSLog(@"广告物料未加载成功");
        return;
    }
    [self.splashAd sendWinnerNotificationWith:nil];
    [self.splashAd showAdInWindow:self.view.window];
}

- (void)sendLossNotification {
    [self.splashAd sendLossNotificationWithWinnerPrice:@"" info:@{@"loss_reason": @"101"}];
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
