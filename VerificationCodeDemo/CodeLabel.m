//
//  CodeLabel.m
//  VerificationCodeDemo
//
//  Created by feng on 2018/4/4.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import "CodeLabel.h"

@interface CodeLabel ()

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGFloat spacing;

@end

@implementation CodeLabel

- (id)initWithHeight:(CGFloat)height spacing:(CGFloat)spacing {
    self = [super init];
    if (self) {
        self.height = height;
        self.spacing = spacing;
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //计算每位验证码/密码的所在区域的宽和高
    CGFloat width = (rect.size.width - (self.numberOfVertificationCode-1) * _spacing) / (CGFloat)self.numberOfVertificationCode;
    
    CGFloat height = self.height;
    
    if (height == 0) {
        height = rect.size.height;
    }
    
    // 将每位验证码/密码绘制到指定区域
    for (int i = 0; i < self.text.length; i++) {
        // 计算每位验证码/密码的绘制区域
        CGRect tempRect = CGRectMake((width+_spacing) * i, 0, width, height);
        if (self.secureTextEntry) { // 密码，显示圆点
            UIImage *dotImage = [UIImage imageNamed:@"dot"];
            // 计算圆点的绘制区域
            CGPoint securityDotDrawStartPoint = CGPointMake((width+_spacing) * i + (width - dotImage.size.width) / 2.0, (tempRect.size.height - dotImage.size.height) / 2.0);
            // 绘制圆点
            [dotImage drawAtPoint:securityDotDrawStartPoint];
        } else { // 验证码，显示数字
            // 遍历验证码/密码的每个字符
            NSString *charecterString = [NSString stringWithFormat:@"%c", [self.text characterAtIndex:i]];
            // 设置验证码/密码的现实属性
            NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
            
            attributes[NSFontAttributeName] = self.font;
            // 计算每位验证码/密码的绘制起点（为了使验证码/密码位于tempRect的中部，不应该从tempRect的重点开始绘制）
            // 计算每位验证码/密码的在指定样式下的size
            CGSize characterSize = [charecterString sizeWithAttributes:attributes];
            CGPoint vertificationCodeDrawStartPoint = CGPointMake((width+_spacing) * i + (width - characterSize.width) / 2.0, (tempRect.size.height - characterSize.height) / 2.0);
            // 绘制验证码/密码
            [charecterString drawAtPoint:vertificationCodeDrawStartPoint withAttributes:attributes];
        }
    }
}

@end
