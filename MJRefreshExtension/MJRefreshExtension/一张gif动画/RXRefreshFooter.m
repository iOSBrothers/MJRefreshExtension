//
//  RXRefreshFooter.m
//  MJRefreshExtension
//
//  Created by srx on 2017/9/11.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXRefreshFooter.h"

@interface RXRefreshFooter ()
@property (weak, nonatomic)UILabel * label;
@property (weak, nonatomic)UIImageView * loading;
@end

@implementation RXRefreshFooter

#pragma mark - ~~~~~~~~~~~ 重写方法 ~~~~~~~~~~~~~~~
#pragma mark - ~~~~~~~~~~~ 在这里做一些初始化配置(比如添加子控件)
- (void)prepare {
    [super prepare];
    // 设置控件的高度
    self.mj_h = 60;
    
    //添加label
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 30, 30);
    label.backgroundColor = [UIColor clearColor];
    label.text = @"srx";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:8];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _label = label;
    
    UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_img"]];
    logo.frame = CGRectMake(0, 0, 30, 30);
    [self addSubview:logo];
    self.loading = logo;
}

#pragma mark - ~~~~~~~~~~~ 在这里设置自控制的位置和尺寸 ~~~~~~~~~~~~~~~
- (void)placeSubviews {
    /* === 不要 super ===*/
    
    self.loading.center = CGPointMake(self.mj_w * 0.5, self.loading.mj_h - 5);
    self.label.center = self.loading.center;
}


#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self animationStop];
            break;
        case MJRefreshStatePulling:
            [self animationStart];
            break;
        case MJRefreshStateRefreshing:
            [self animationStart];
            break;
        default:
            break;
    }
}

- (void)animationStop {
    [self.loading.layer removeAllAnimations];
}

- (void)animationStart {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //顺时针 M_PI * 2.0
    //逆时针 -(M_PI * 2.0)
    rotationAnimation.toValue = [NSNumber numberWithFloat: (M_PI * 2.0) ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99;
    
    [self.loading.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


@end
