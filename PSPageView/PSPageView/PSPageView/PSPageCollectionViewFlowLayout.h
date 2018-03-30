//
//  PSPageCollectionViewFlowLayout.h
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 通过设置offset的值，达到初始化的pageView默认显示某一页的效果，默认显示第一页
 */
@interface PSPageCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) CGFloat offset;


@end
