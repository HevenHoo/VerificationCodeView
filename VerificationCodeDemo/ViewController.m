//
//  ViewController.m
//  VerificationCodeDemo
//
//  Created by feng on 2018/4/4.
//  Copyright © 2018年 Feng. All rights reserved.
//

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define OldiPhone (iPhone4 || iPhone5)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#import "ViewController.h"
#import "SRVerificationCodeView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"bar4_bg4"];
    [self.view addSubview:backgroundImageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"验证码已发送到您的手机，请输入验证码";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    NSInteger numberOfVertificationCode = 6;
    CGFloat spacing = 10;
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat codeViewWidth = 320;

    if (iPhone6Plus) {
        codeViewWidth = 340;
        spacing = 12;
    } else if (OldiPhone) {
        codeViewWidth = 290;
        spacing = 8;
    } else if (iPad) {
        codeViewWidth = 360;
        spacing = 15;
    }
    
    CGFloat padding = (screenWidth-codeViewWidth)/2.0;

    CGFloat codeViewHeight = (screenWidth-padding*2-(numberOfVertificationCode-1)*spacing) / numberOfVertificationCode;
    
    SRVerificationCodeView *codeView = [[SRVerificationCodeView alloc] initWithHeight:codeViewHeight spacing:spacing];
    codeView.numberOfVertificationCode = numberOfVertificationCode;
    [self.view addSubview:codeView];
    
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(95+64);
        make.left.mas_equalTo(self.view).offset(padding);
        make.right.mas_equalTo(self.view).offset(-padding);
    }];
    
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(18);
        make.left.mas_equalTo(titleLabel);
        make.width.mas_equalTo(codeViewWidth);
        make.height.mas_equalTo(codeViewHeight);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
