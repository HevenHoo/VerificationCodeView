//
//  SRVerificationCodeView.h
//  VerificationCodeDemo
//
//  Created by feng on 2018/4/4.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface SRVerificationCodeView : UIView

- (id)initWithHeight:(CGFloat)height spacing:(CGFloat)spacing;

@property (copy, nonatomic) NSString *backgroudImageName;

@property (copy, nonatomic) NSString *vertificationCode;

@property (assign, nonatomic) NSInteger numberOfVertificationCode;

@property (assign, nonatomic) BOOL secureTextEntry;

@end
