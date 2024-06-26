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
@property (nonatomic, assign) BOOL  isLoded;

@end

@implementation MentaRewardVideoViewController

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
    if (self.rewardVideoAd) {
        self.rewardVideoAd = nil;
    }
    
    self.rewardVideoAd = [[MentaMediationRewardVideo alloc] initWithPlacementID:@"P0021"];
    self.rewardVideoAd.delegate = self;

    [self.rewardVideoAd loadAd];
}

- (void)showAd {
    
    if (![self.rewardVideoAd isAdReady]) {
        NSLog(@"广告物料未加载成功");
        return;
    }
    
    [self.rewardVideoAd showAdFromRootViewController:self];
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
