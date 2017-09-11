//
//  RXRefreshHeader.h
//  MJRefreshExtension
//
//  Created by srx on 2017/9/11.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//这个我是没有继承 MJ ，如果想继承，就看footer，一样的
//这个我主要想表达，不要太依赖第三方

#import <UIKit/UIKit.h>

@interface RXRefreshHeader : UIView

@property (nonatomic, copy)UIColor * textColor;

- (void)animationStop;

- (void)animationStart;

@end


/*
    这个不一定用于 header/footer
 
    这个还可以作为 播放器的加载    等等【加载样式】
 */
