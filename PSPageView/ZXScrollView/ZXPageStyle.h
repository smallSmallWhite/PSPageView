//
//  ZXPageStyle.h
//  PSPageView
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXPageStyle : NSObject

/**
 标题是否可以滚动
 */
@property (nonatomic,assign) BOOL isTitleScrollEnable;
/**
 titleView的高度
 */
@property (nonatomic,assign) CGFloat titleViewHeight;
/**
 标题颜色
 */
@property (nonatomic,strong) UIColor *titleColor;
/**
 选中标题的颜色
 */
@property (nonatomic,strong) UIColor *titleSelectedColor;
/**
 标题的字体大小
 */
@property (nonatomic,assign) CGFloat titleFontSize;
/**
 标题的背景颜色
 */
@property (nonatomic,strong) UIColor *titleViewBackgroundColor;
/**
 标题label之间的间距
 */
@property (nonatomic,assign) CGFloat titleMargin;
/**
 是否显示滚动条
 */
@property (nonatomic,assign) BOOL isShowBottomLine;
/**
 滚动条的颜色
 */
@property (nonatomic,strong) UIColor *bottomLineColor;
/**
 滚动条的高度
 */
@property (nonatomic,assign) CGFloat bottomLineHeight;
/**
 是否需要缩放的功能
 */
@property (nonatomic,assign) BOOL isScaleEnable;
/**
 缩放的比例
 */
@property (nonatomic,assign) CGFloat maximumScaleFactor;
/**
 是否需要显示coverView
 */
@property (nonatomic,assign) BOOL isShowCoverView;
/**
 coverView的背景颜色
 */
@property (nonatomic,strong) UIColor *coverViewBackgroundColor;
/**
 coverView的透明度
 */
@property (nonatomic,assign) CGFloat coverViewAlpha;
/**
 coverView的间距
 */
@property (nonatomic,assign) CGFloat coverMargin;
/**
 coverView的高度
 */
@property (nonatomic,assign) CGFloat coverViewHeight;
/**
 coverView的圆角
 */
@property (nonatomic,assign) CGFloat coverViewRadius;
/**
 contentView是否可以滚动
 */
@property (nonatomic,assign) BOOL isContentScrollEnable;
/**
 contentView的背景颜色
 */
@property (nonatomic,strong) UIColor *contentViewBackgroundColor;

@end
