//
//  GHSMJGifFooter.m
//  MJRefreshExtension
//
//  Created by srx on 2017/9/11.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXRefreshGifFooter.h"



#define BoundlePath(string_imageName) [[NSBundle mainBundle] pathForResource:(string_imageName) ofType:@"png"]

#define ImageName(string_imageName,int_index) [NSString stringWithFormat:@"%@%zd",string_imageName, int_index]


#define gifSize CGSizeMake(gifViewWidth, gifViewHeight)



@implementation RXRefreshGifFooter
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    //隐藏后，图片就居中显示了
    self.stateLabel.hidden = YES;
    
    NSString * name = @"loding_";
    
    
/*
     我的项目
     修改了 MJRefreshFooter.h 。实现根据类型 选择刷新样式
       【新增】3字段 endRefreshType、gifImagesCount、gifImageName
          根据 【endRefreshType】 去改变 gifImagesCount、gifImageName
              # 我的endRefreshType 目前是4种 样式(不算MJ默认的那些)。
 
       【修改】
          ① i<= self.gifImagesCount; i++) {
          ② NSString * string = ImageName(self.gifImageName,
 
     gifImageName == 上面的name
 
     例子
     _table.mj_footer = [GHSMJGifFooter footer....];
     _table.mj_footer.endRefreshType = NoMoreDataType_home_buyer;
 
    这里就不修改了，MJRefresh我pod后，没有放入github库中。
 
 */
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i++) {
        NSString * string = ImageName(name, i);
        UIImage * image = [UIImage imageNamed:string];
        if(image == nil) {
            return;
        }
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i++) {
        NSString * string = ImageName(name, i);
        UIImage * image = [UIImage imageNamed:string];
        if(image == nil) {
            return;
        }
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    
    
    //图片地址 为 loading_0.png、loading_1.png、loading_2.png ....
}


//下面的必须写

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
}

@end
