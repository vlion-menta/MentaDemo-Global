//
//  MentaRewardVideoViewController.m
//  Menta-Global
//
//  Created by jdy on 2024/6/21.
//

#import "MentaRewardVideoViewController.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface MentaRewardVideoViewController () <MentaMediationRewardVideoDelegate>

@property (nonatomic, strong) MentaMediationRewardVideo *rewardVideoAd;
@property (nonatomic, strong) UIButton *btnLoad;
@property (nonatomic, strong) UIButton *btnShow;
@property (nonatomic, strong) UIButton *btnLoss;
@property (nonatomic, strong) UITextField *placementIDField;

@end

@implementation MentaRewardVideoViewController

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
    self.placementIDField.placeholder = @"P0021";
    self.placementIDField.borderStyle = UITextBorderStyleNone;
    self.placementIDField.layer.borderColor = [UIColor blackColor].CGColor;
    self.placementIDField.layer.borderWidth = 2.0;
    self.placementIDField.layer.cornerRadius = 5.0;
    self.placementIDField.keyboardType = UIKeyboardTypeNumberPad;
    self.placementIDField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.placementIDField];
}

- (void)loadAd {
    if (self.rewardVideoAd) {
        self.rewardVideoAd = nil;
    }
    
    NSString *placementID = self.placementIDField.text;
    if (!placementID || placementID.length == 0) {
        placementID = @"P0021";
    }
    
    self.rewardVideoAd = [[MentaMediationRewardVideo alloc] initWithPlacementID:placementID];
    self.rewardVideoAd.delegate = self;

    [self.rewardVideoAd loadAd];
}

- (void)showAd {
    
    if (![self.rewardVideoAd isAdReady]) {
        NSLog(@"广告物料未加载成功");
        return;
    }
    
    [self.rewardVideoAd sendWinnerNotificationWith:nil];
    [self.rewardVideoAd showAdFromRootViewController:self];
}

- (void)sendLossNotification {
    [self.rewardVideoAd sendLossNotificationWithWinnerPrice:@"" info:@{@"loss_reason": @"101"}];
}

#pragma mark - MentaMediationRewardVideoDelegate

// 广告素材加载成功
- (void)menta_rewardVideoDidLoad:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 广告素材加载失败
- (void)menta_rewardVideoLoadFailedWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_rewardVideoRenderSuccess:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 广告素材渲染失败
- (void)menta_rewardVideoRenderFailureWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频广告即将展示
- (void)menta_rewardVideoWillPresent:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频广告展示失败
- (void)menta_rewardVideoShowFailWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频广告曝光
- (void)menta_rewardVideoExposed:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频广告点击
- (void)menta_rewardVideoClicked:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频广告跳过
- (void)menta_rewardVideoSkiped:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频达到奖励节点
- (void)menta_rewardVideoDidEarnReward:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频播放完成
- (void)menta_rewardVideoPlayCompleted:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

// 激励视频广告关闭
-(void)menta_rewardVideoClosed:(MentaMediationRewardVideo *)rewardVideo {
    NSLog(@"%s", __FUNCTION__);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
