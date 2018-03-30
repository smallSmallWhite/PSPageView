//
//  PSPageReloadable.h
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
// 如果contentView中的view需要实现某些刷新的方法，请让对应的childViewController遵守这个协议
@protocol PSPageReloadable <NSObject>
@optional;
// 如果需要双击标题刷新或者作其他处理，请实现这个方法
- (void)titleViewDidSelectedSameTitle;
//点击标签时，请实现这个方法
- (void)clickTitleWithIndex:(NSInteger)index
                  withTitles:(NSMutableArray *)titles
withViewController:(UIViewController *)viewController;
// 如果pageContentView滚动到下一页停下来需要刷新或者作其他处理，请实现这个方法
- (void)contentViewDidEndScroll;
//滚动到当前页面时，请实现这个方法
- (void)contentViewScrollViewCurrentIndex:(NSInteger)currentIndex
                                withTitles:(NSMutableArray *)titles
                       withViewController:(UIViewController *)viewController;

@end
