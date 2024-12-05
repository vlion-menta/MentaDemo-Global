//
//  MentaSelfRenderViewController.m
//  Menta-Global
//
//  Created by jdy on 2024/6/12.
//

#import "MentaSelfRenderViewController.h"
#import <MentaMediationGlobal/MentaMediationGlobal-umbrella.h>

@interface MentaSelfRenderViewController () <MentaNativeSelfRenderDelegate>

@property (nonatomic, strong) UIButton *btnLoad;
@property (nonatomic, strong) UIButton *btnLoss;
@property (nonatomic, strong) UITextField *placementIDField;
@property (nonatomic, assign) BOOL isLoded;

@property (nonatomic, strong) MentaMediationNativeSelfRender *nativeAd;

@property (nonatomic, strong) UIView<MentaMediationNativeSelfRenderViewProtocol> *nativeAdView; // adView
@property (nonatomic, strong) MentaMediationNativeSelfRenderModel *nativeAdData; // adData


// 自定义广告adview的控件
@property (nonatomic, strong) UIImageView *imageMaterial;
@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) VlionLogoView *imageMvlionIcon;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDesc;
@property (nonatomic, strong) UILabel *labPrice;
@property (nonatomic, strong) UILabel *labClose;

@end

@implementation MentaSelfRenderViewController

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
    
    UIButton * btnShowInView = [UIButton buttonWithType:UIButtonTypeSystem];
    btnShowInView.frame = CGRectMake(centerX, 150, buttonWidth, buttonHeight);
    [btnShowInView setTitle:@"展现广告" forState:UIControlStateNormal];
    [btnShowInView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnShowInView addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    btnShowInView.backgroundColor = [UIColor blackColor];
    btnShowInView.layer.cornerRadius = 5;
    [self.view addSubview:btnShowInView];
    
    self.btnLoss = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btnLoss.frame = CGRectMake(centerX, 200, buttonWidth, buttonHeight);
    [self.btnLoss setTitle:@"send bid fail" forState:UIControlStateNormal];
    [self.btnLoss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnLoss addTarget:self action:@selector(sendLossNotification) forControlEvents:UIControlEventTouchUpInside];
    self.btnLoss.backgroundColor = [UIColor blackColor];
    self.btnLoss.layer.cornerRadius = 5;
    [self.view addSubview:self.btnLoss];
    
    self.placementIDField = [[UITextField alloc] initWithFrame:CGRectMake(centerX, 250, buttonWidth, buttonHeight)];
    self.placementIDField.placeholder = @"P0020";
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
        [self.nativeAdView removeFromSuperview];
    }

    if (!self.view.window.rootViewController) {
        return;
    }
    
    NSString *placementID = self.placementIDField.text;
    if (!placementID || placementID.length == 0) {
//        placementID = @"P0020";
        placementID = @"P0019";
    }
    self.nativeAd = [[MentaMediationNativeSelfRender alloc] initWithPlacementID:placementID];
    self.nativeAd.delegate = self;
    
    [self.nativeAd loadAd];

}

- (void)showAd {
    if (!self.isLoded) {
        NSLog(@"请先加载广告");
        return;
    }
    
    [self.nativeAd sendWinnerNotificationWith:nil];
    [self createCustomNativeView];
}

- (void)sendLossNotification {
    [self.nativeAd sendLossNotificationWithWinnerPrice:@"" info:@{@"loss_reason": @"101"}];
}

- (void)createCustomNativeView {
    self.nativeAdView.frame = CGRectMake(10, self.view.frame.size.height - 300, self.view.frame.size.width - 20, 200);
    self.nativeAdView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.nativeAdView];
    
    self.labClose.text = @"点我触发关闭回调";
    self.labTitle.text = [NSString stringWithFormat:@"title: %@", self.nativeAdData.title];
    self.labDesc.text = [NSString stringWithFormat:@"desc: %@", self.nativeAdData.des];
    self.labPrice.text = [NSString stringWithFormat:@"price: %@", self.nativeAdData.eCPM];
    
    [self.imageIcon setImageWithURL:[NSURL URLWithString:self.nativeAdData.iconURL]];
    self.imageMvlionIcon = self.nativeAdData.adLogo;
    
    if (self.nativeAdData.isVideo) {
        [self.nativeAdView menta_registerClickableViews:@[self.nativeAdView.mediaView] closeableViews:@[self.labClose]];
    } else {
        [self.imageMaterial setImageWithURL:[NSURL URLWithString:self.nativeAdData.materialURL]];
        [self.nativeAdView menta_registerClickableViews:@[self.imageMaterial, self.labTitle] closeableViews:@[self.labClose]];
    }
    
    [self setupViews];
}

- (void)setupViews {
    
    [self.nativeAdView addSubview:self.imageMaterial];
    if (self.nativeAdData.isVideo) {
        [self.nativeAdView addSubview:self.nativeAdView.mediaView];
        self.imageMaterial.hidden = YES;
        
        [self.nativeAdView.mediaView mas_makeConstraints:^(MentaMASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.nativeAdView);
            make.width.equalTo(@(100));
        }];
    }
    [self.nativeAdView addSubview:self.imageIcon];
    [self.nativeAdView addSubview:self.imageMvlionIcon];
    [self.nativeAdView addSubview:self.labTitle];
    [self.nativeAdView addSubview:self.labDesc];
    [self.nativeAdView addSubview:self.labPrice];
    [self.nativeAdView addSubview:self.labClose];

    
    self.labTitle.textColor = [UIColor blackColor];
    self.labDesc.textColor = [UIColor redColor];
    self.labPrice.textColor = [UIColor orangeColor];
    
    self.labClose.backgroundColor = [UIColor blackColor];
    self.labClose.textColor = [UIColor whiteColor];
    self.labClose.numberOfLines = 0;
    
    [self.imageMaterial mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.nativeAdView);
        make.width.equalTo(@(100));
    }];
    
    
    
    [self.imageIcon mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.left.equalTo(self.imageMaterial.mas_right).offset(10);
        make.top.equalTo(self.nativeAdView);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];

    [self.imageMvlionIcon mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.right.equalTo(self.nativeAdView);
        make.top.equalTo(self.nativeAdView);
        make.width.mas_equalTo(34.0);
        make.height.mas_equalTo(12.0);
    }];

    [self.labTitle mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.top.equalTo(self.imageIcon.mas_bottom).offset(10);
        make.width.equalTo(@250);
        make.height.equalTo(@30);
        make.left.equalTo(self.imageIcon);
    }];
    
    [self.labDesc mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(10);
        make.width.equalTo(@250);
        make.height.equalTo(@30);
        make.left.equalTo(self.imageIcon);
    }];
    
    [self.labPrice mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.top.equalTo(self.labDesc.mas_bottom).offset(10);
        make.width.equalTo(@250);
        make.height.equalTo(@30);
        make.left.equalTo(self.imageIcon);
    }];

    [self.labClose mas_makeConstraints:^(MentaMASConstraintMaker *make) {
        make.bottom.equalTo(self.nativeAdView);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
        make.right.equalTo(self.nativeAdView);
    }];
}

#pragma mark - MentaNativeSelfRenderDelegate

- (void)menta_nativeSelfRenderLoadSuccess:(NSArray<MentaMediationNativeSelfRenderModel *> *)nativeSelfRenderAds
                         nativeSelfRender:(MentaMediationNativeSelfRender *)nativeSelfRender {
    NSLog(@"%s", __FUNCTION__);
    self.isLoded = YES;
    self.nativeAdData = nativeSelfRenderAds.firstObject;
    self.nativeAdView = self.nativeAdData.selfRenderView;
}

- (void)menta_nativeSelfRenderLoadFailure:(NSError *)error
                         nativeSelfRender:(MentaMediationNativeSelfRender *)nativeSelfRender {
    NSLog(@"%s", __FUNCTION__);
}

- (void)menta_nativeSelfRenderViewExposed {
    NSLog(@"%s", __FUNCTION__);
}

- (void)menta_nativeSelfRenderViewClicked {
    NSLog(@"%s", __FUNCTION__);
}

- (void)menta_nativeSelfRenderViewClosed {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - lazy load

- (UIImageView *)imageMaterial {
    if (!_imageMaterial) {
        _imageMaterial = [UIImageView new];
    }
    return _imageMaterial;
}

- (UIImageView *)imageIcon {
    if (!_imageIcon) {
        _imageIcon = [UIImageView new];
    }
    return _imageIcon;
}

- (VlionLogoView *)imageMvlionIcon {
    if (!_imageMvlionIcon) {
        _imageMvlionIcon = [[VlionLogoView alloc] init];
    }
    return _imageMvlionIcon;
}

- (UILabel *)labClose {
    if (!_labClose) {
        _labClose = [UILabel new];
    }
    return _labClose;
}

- (UILabel *)labTitle {
    if (!_labTitle) {
        _labTitle = [UILabel new];
    }
    return _labTitle;
}

- (UILabel *)labDesc {
    if (!_labDesc) {
        _labDesc = [UILabel new];
    }
    return _labDesc;
}

- (UILabel *)labPrice {
    if (!_labPrice) {
        _labPrice = [UILabel new];
    }
    return _labPrice;
}

@end
