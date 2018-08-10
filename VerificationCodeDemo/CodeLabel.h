//
//  CodeLabel.h
//  VerificationCodeDemo
//
//  Created by feng on 2018/4/4.
//  Copyright © 2018年 Feng. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface CodeLabel : UILabel

- (id)initWithHeight:(CGFloat)height spacing:(CGFloat)spacing;

@property (assign, nonatomic) NSInteger numberOfVertificationCode;

@property (assign, nonatomic) bool secureTextEntry;

@end
