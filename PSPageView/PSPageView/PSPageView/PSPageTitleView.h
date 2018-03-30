//
//  PSPageTitleView.h
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPageReloadable.h"
@class PSPageTitleView;
@class PSPageStyle;


@protocol PSPageTitleViewDelegate <NSObject>

//pageContentView的刷新代理
@property (weak, nonatomic) id <PSPageReloadable>reloader;

- (void)clickTitleView:(PSPageTitleView *)titleView
             withIndex:(NSInteger)currentIndex;

@end

@interface PSPageTitleView : UIView

@property (weak, nonatomic) id <PSPageTitleViewDelegate>delegate;
@property (copy, nonatomic) void (^clickHandler)(PSPageTitleView *titleView,NSInteger tag);
//点击的下标
@property (assign, nonatomic) NSInteger currentIndex;
//存放UIlabel的数组
@property (strong, nonatomic) NSMutableArray *titleLabels;
@property (strong, nonatomic) PSPageStyle *style;
//标题数组
@property (strong, nonatomic) NSMutableArray *titles;
//控制器数组
@property (strong, nonatomic) NSMutableArray *childControllers;

- (instancetype)initWithFrame:(CGRect)frame
            withStyle:(PSPageStyle *)style
           withTitles:(NSMutableArray *)titles
     withCurrentIndex:(NSInteger)currentIndex
     withChildViewControllers:(NSMutableArray *)childControllers;





@end

