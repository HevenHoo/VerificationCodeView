//
//  SRVerificationCodeView.m
//  VerificationCodeDemo
//
//  Created by feng on 2018/4/4.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import "SRVerificationCodeView.h"
#import "CodeLabel.h"

@interface SRVerificationCodeView()<UITextFieldDelegate>

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGFloat spacing;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) CodeLabel *codeLabel;

@end

@implementation SRVerificationCodeView

- (instancetype)initWithHeight:(CGFloat)height spacing:(CGFloat)spacing {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.height = height;
        self.spacing = spacing;
        
        self.numberOfVertificationCode = 6;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self insertSubview:self.textField atIndex:0];
    
    for (int i = 0; i < self.numberOfVertificationCode; i++) {
        UIView *rectView = [self rectView];
        CGFloat height = self.height;
        CGFloat originX = i*(height+_spacing);
        [rectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.mas_height);
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(originX);
        }];
    }
    
    [self addSubview:self.codeLabel];

    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (UIView *)rectView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    return view;
}

- (void)setBackgroudImageName:(NSString *)backgroudImageName {
    _backgroudImageName = backgroudImageName;
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:self.backgroudImageName];
    [self insertSubview:self.backgroundImageView belowSubview:self.codeLabel];
}

- (void)setNumberOfVertificationCode:(NSInteger)numberOfVertificationCode {
    _numberOfVertificationCode = numberOfVertificationCode;
    self.codeLabel.numberOfVertificationCode = _numberOfVertificationCode;
}
- (void)setSecureTextEntry:(bool)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    self.codeLabel.secureTextEntry = _secureTextEntry;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length != 0) {
        // 不删除字符
        if (textField.text.length < self.numberOfVertificationCode) {
            self.codeLabel.text = [textField.text stringByAppendingString:string];
            self.vertificationCode = self.codeLabel.text;
            return YES;
        } else {
            return NO;
        }
    } else {
        // 是删除字符
        self.codeLabel.text = [textField.text substringToIndex:textField.text.length - 1];
        self.vertificationCode = self.codeLabel.text;
        return YES;
    }
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:self.bounds];
        _textField.font = [UIFont systemFontOfSize:23];
        _textField.hidden = YES;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
    }
    
    return _textField;
}

- (CodeLabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [[CodeLabel alloc] initWithHeight:self.height spacing:self.spacing];
        _codeLabel.textColor = [UIColor blackColor];
        _codeLabel.numberOfVertificationCode = self.numberOfVertificationCode;
        _codeLabel.secureTextEntry = self.secureTextEntry;
        _codeLabel.font = [UIFont systemFontOfSize:24];
    }
    return _codeLabel;
}

@end
