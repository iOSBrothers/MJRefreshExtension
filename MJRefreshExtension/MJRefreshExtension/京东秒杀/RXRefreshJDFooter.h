//
//  RXRefreshJDFooter.h
//  MJRefreshExtension
//
//  Created by srx on 2017/9/11.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import <MJRefresh/MJRefreshBackStateFooter.h>

typedef void (^MJRefreshComponentReturnBlock)();

@interface RXRefreshJDFooter : MJRefreshBackStateFooter
@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) BOOL isRuturn;
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;


//一定要先用MJ.footer 初始化后，在用下面的方法
/** 创建footer 下一场的block */
@property (nonatomic, copy) MJRefreshComponentReturnBlock JDReturnBlock;

/** 创建footer 下一场的 performSelector*/
- (void)JDFooterWithReturnTarget:(id)target refreshingAction:(SEL)action;

@end


/* 简单实例
 - (void)mjFreshConfigUI {
     __weak typeof(self)weakSelf = self;
     self.tableView.mj_footer = [RXRefreshJDFooter footerWithRefreshingBlock:^{
         [weakSelf mjRefreshing];
     }];
     
     RXRefreshJDFooter * footer = (RXRefreshJDFooter *)self.tableView.mj_footer;
         footer.returnBlock = ^{
         NSLog(@"下一场");
     };
 }
 
 - (void)mjRefreshing {
     RXRefreshJDFooter * footer = (RXRefreshJDFooter * )self.tableView.mj_footer;
     if(footer.isRuturn) {
         NSLog(@"viewController");
     
         //这里不要写，除非自己写结束动画
         //        [self.tableView.mj_footer endRefreshing];
     
     
         //结束的动画，我在 MJ的继承类有写，不需要这里写
         return;
     }
     
     NSLog(@"MJ 开始你的表演");
     
     __weak typeof(self)weakSelf = self;
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         NSLog(@"MJ ~结束~你的表演");
         weakSelf.dataCount += 5;
         [weakSelf.tableView.mj_footer endRefreshing];
         [weakSelf.tableView reloadData];
         if(weakSelf.dataCount > 15){
             RXRefreshJDFooter * weakfooter = (RXRefreshJDFooter * )weakSelf.tableView.mj_footer;
             weakfooter.text = @"跳转下一场";
             weakfooter.isRuturn = YES;
         }
     });
 }
 
 */
