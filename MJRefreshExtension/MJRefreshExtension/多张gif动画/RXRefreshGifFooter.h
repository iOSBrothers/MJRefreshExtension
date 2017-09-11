//
//  GHSMJGifFooter.h
//  MJRefreshExtension
//
//  Created by srx on 2017/9/11.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
// 一张 png图片 加载

#import <MJRefresh/MJRefreshBackGifFooter.h>

@interface RXRefreshGifFooter : MJRefreshBackGifFooter

@end


//MJRefresh 源码demo  DIY改编


/*
 ======================================================
  # 下面是 ps 把 xx.gif 格式 ，输出为多个png 操作流程
    -------------------------------------------
  
  # 当【设计师】给你 xx.gif ，我们一般是让给 png组 图片。 【设计师】say:"WHAT❓"。 你说xxx
  # 我告诉你技能，不必说那么多，你就是全能！
  
  # 下面是流程，超简单的
 
  ① 用 ps(PhotoShop) 打开 xxx.gif 图片
  ② ps桌面 导航栏 -> 文件 -> 导出 -> 渲染视频
 
  ③ 名字 (例如：loading_.png) 以便loading_0.png   loading_1.png
  ④ 选择一个空文件夹
  ⑤ 起始编号  0-1
        loading_0.png   loading_1.png
     起始编号  0-2
        loading_00.png   loading_01.png
  ⑥ 【渲染】过几秒，去你【保存的文件】里面看，就知道啦 🌶🌶🌶
 
 ======================================================
 
 
  # 你以为结束了吗？ 还没呢
 
  # 下一步 更改所有 为 xx@2x.png 结尾，这样就是2倍图了
 
  ① 打开 你【保存的文件】
  ② command+a (选择所有图片)
  ③ 右键(哦！不对 是双指touch😆，不管了，下面的我都说为右键了哈 O(∩_∩)O )
  ④ 给【xx个项目重新命名】
  ⑤ .png  --替换成--> @2x.png
 ======================================================
 
  # 你以为结束了吗？ 还没呢😝
  # 最后一个操作了，就是把图片导入工程中，一键哦😯
 
  ① 打开 【工程】-> Assets.xcassets
  ② 底部【+】 -> 右键 ->【New Folder】 -> 起个名字吧(建议见其名问其意)
  ③ 打开 你【保存的文件】 --拖拽--> 【你刚起名字的文件中】
 
 
   ok啦 ！  ok啦 ！  ok啦 ！  ok啦 ！
 
 
 
    没了 ！！
 */









