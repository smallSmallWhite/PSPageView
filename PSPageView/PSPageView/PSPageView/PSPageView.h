//
//  PSPageView.h
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPageStyle.h"
@class PSPageTitleView;

/*
 通过这个类创建的pageView，默认titleView和contentView连在一起，效果类似于网易新闻
 只能用代码创建，不能在xib或者storyboard里面使用
 */
@interface PSPageView : UIView
//样式
@property (nonatomic,strong) PSPageStyle *style;
//标题数组
@property (nonatomic,strong) NSMutableArray *titles;
//当前选中的下标
@property (nonatomic,assign) NSInteger currentIndex;
//控制器数组
@property (nonatomic,strong) NSMutableArray *childViewControllers;
- (instancetype)initWithFrame:(CGRect)frame
                style:(PSPageStyle *)style
               titles:(NSMutableArray *)titles
 childViewControllers:(NSMutableArray *)childViewControllers
             withCurrentIndex:(NSInteger)currentIndex;


@end
