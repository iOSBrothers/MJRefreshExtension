//
//  ViewController.m
//  MJRefreshExtension
//
//  Created by srx on 2017/9/11.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "ViewController.h"

//基础库
#import <MJRefresh/MJRefresh.h>
#import <MJRefresh/MJRefreshHeader.h>

//一张gif图的刷新样式
#import "RXRefreshHeader.h"
#import "RXRefreshFooter.h"

//多张png图 拼成gif样式
#import "RXRefreshGifFooter.h"

//【京东-秒杀列表】footer样式
#import "RXRefreshJDFooter.h"

#define weak(weakSelf)  __weak __typeof(&*self)weakSelf = self

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy)UITableView * tableView;
@property (nonatomic, assign) NSInteger dataCount;


@property (nonatomic, copy) RXRefreshHeader * gifHeader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化table 并 添加到 控制器页面里
    [self.view addSubview:self.tableView];
    
    //初始化 数据为10条
    self.dataCount = 10;
    
    /* 下面的header  和  footer 只能各选一个，多了会替换   */
    
    
    //添加一张 gif 的 header
    [self headerAddGif];
    
    //添加一张 gif 的 footer
//    [self footerAddGif];
    
    
    //添加多张 gif【组】 的 header
    //[self headerAddPngs]; 这个不要打开
    
    //添加多张 gif【组】 的 footer
//    [self footerAddPngs];
    
    
    //添加【京东-秒杀列表】的footer 【注意这个是 上面其一的footer 配合使用】
    [self footerAddJD];
    
}

#pragma mark -----------------------------------
#pragma mark -----------------------------------
#pragma mark --------- 一张gif的header ----------
- (void)headerAddGif {
    //自定义的，不是 继承MJ
    [self.tableView addSubview:self.gifHeader];
    
    weak(weakSelf);
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf.gifHeader animationStart];
        [weakSelf pullRefreshing:NO];
    }];
    
    self.tableView.mj_header.endRefreshingCompletionBlock = ^{
        [weakSelf.gifHeader animationStop];
    };
}

- (RXRefreshHeader *)gifHeader {
    if(!_gifHeader) {
        CGRect frame = CGRectZero;
        frame.origin.y = -40;
        frame.size = self.view.bounds.size;
        _gifHeader = [[RXRefreshHeader alloc] initWithFrame:frame];
    }
    return _gifHeader;
}

#pragma mark --------- 添加一张 gif 的 footer ----------
- (void)footerAddGif {
    weak(weakSelf);
    self.tableView.mj_footer = [RXRefreshFooter footerWithRefreshingBlock:^{
        NSLog(@"RXRefreshFooter 一张gif图 刷新样式");
        [weakSelf pullRefreshing:YES];
    }];
}



#pragma mark --------- 添加多张 gif【组】 的 header ----------
- (void)headerAddPngs __deprecated_msg("由于和footer一样，没有写，看footerAddPngs") {
    NSAssert(NO, @"由于和footer一样，没有写，看RXRefreshGifFooter的实现");
}

#pragma mark --------- 添加多张 gif【组】 的 footer ----------
- (void)footerAddPngs {
    weak(weakSelf);
    self.tableView.mj_footer = [RXRefreshGifFooter footerWithRefreshingBlock:^{
        NSLog(@"RXRefreshGifFooter 多张png图 刷新样式");
        [weakSelf pullRefreshing:YES];
    }];
}



#pragma mark ---模拟【请求网络】加载数据-------
- (void)pullRefreshing:(BOOL)isFooter {
    weak(weakSelf);
    NSLog(@"开始request url");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"request final");
        weakSelf.dataCount += 5;
        if(isFooter) {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        else {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        [weakSelf.tableView reloadData];
    });
}




#pragma mark --------- 添加【京东-秒杀列表】的footer ----------
- (void)footerAddJD {
    weak(weakSelf);
    RXRefreshJDFooter * footer = [RXRefreshJDFooter footerWithRefreshingBlock:^{
        NSLog(@"正常刷新");
        [weakSelf pullJDRefreshing];
    }];
    
    footer.JDReturnBlock = ^{
        NSLog(@"下一档");
        [weakSelf pullJDNext];
    };
    
    self.tableView.mj_footer = footer;
}



#pragma mark --京东样式的处理----
- (void)pullJDRefreshing {
    weak(weakSelf);
    NSLog(@"开始request url");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"request final");
        
        RXRefreshJDFooter * footer = (RXRefreshJDFooter * )weakSelf.tableView.mj_footer;
        [footer endRefreshing];
        
        if(weakSelf.dataCount > 10) {
            footer.isRuturn = YES;
            footer.text = @"srxboys";
            if(weakSelf.dataCount < 30) {
                weakSelf.dataCount += 5;
            }
            else {
                footer.isRuturn = NO;
                [footer endRefreshingWithNoMoreData];
            }
        }
        else {
            weakSelf.dataCount += 5;
        }
    
        [weakSelf.tableView reloadData];
    });
}


- (void)pullJDNext {
    //一般都是请求一个连接，这里主要是处理，UI样式
    //例如：菜单 选择下一个，并 切换 滚动器(UIScroll、UITable、UICollectionView)
    //我就不切换了 脑补吧。
    [self pullJDRefreshing];
}






#pragma mark -----------------------------------
#pragma mark -----------------------------------
#pragma mark --------- tableView 展示 ----------
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //代理
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
        //注册cell
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        //去掉 table.footer的line
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
