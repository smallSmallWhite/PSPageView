//
//  PSPageContentView.h
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSPageReloadable.h"
@class PSPageTitleView;
@class PSPageContentView;
@class PSPageStyle;
@protocol PSPageContentViewDelegate <NSObject>

- (void)contentViewWithIndex:(NSInteger)index
             withContentView:(PSPageContentView *)contentView;
- (void)contentViewWithSourceIndex:(NSInteger)sourceIndex
                   withTargetIndex:(NSInteger)targetIndex
                   withContentView:(PSPageContentView *)contentView;

@end


@interface PSPageContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame
            withStyle:(PSPageStyle *)style
withChildViewControllers:(NSMutableArray *)childViewControllers
       withStartIndex:(NSInteger)startIndex
                   withTitles:(NSMutableArray *)titles;

/**
存放所有标签的数组
 */
@property (nonatomic,strong) NSMutableArray *titles;

@property (nonatomic,weak) id <PSPageContentViewDelegate>delegate;

@property (nonatomic,weak) id <PSPageReloadable>reloader;

/**
 存放titleView样式
 */
@property (nonatomic,strong) PSPageStyle *style;

/**
 存放所有的控制器数组
 */
@property (nonatomic,strong) NSMutableArray *childViewControllers;

/**
 默认显示的页数
 */
@property (nonatomic,assign) NSInteger startIndex;
/**
 默认的偏移量
 */
@property (nonatomic,assign) CGFloat startOffsetX;
/**
 是否禁止协议
 */
@property (nonatomic,assign) BOOL isForbidDelegate;


@end
