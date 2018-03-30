//
//  ZXCategorySliderBar.h
//  ZXCollectionSliderBar
//
//  Created by anphen on 2017/4/18.
//  Copyright © 2017年 anphen All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXPageStyle.h"

@interface UIView(ZXExtension)

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@end


@protocol ZXCategorySliderBarDelegate <NSObject>

- (void)didSelectedIndex:(NSInteger)index;

@end

@interface ZXCategorySliderBar : UIView

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) ZXPageStyle *style;
@property (nonatomic, assign) NSInteger originIndex;
@property (nonatomic, weak) id<ZXCategorySliderBarDelegate> delegate;
@property (nonatomic, strong) UIView *indicateView;
@property (nonatomic, assign) BOOL isMoniteScroll;
@property (nonatomic, strong) UIScrollView *moniterScrollView;
@property (nonatomic, assign) BOOL isOutScreen;


@property (nonatomic, assign) CGFloat scrollViewLastContentOffset;

- (instancetype)initWithFrame:(CGRect)frame
                    withStyle:(ZXPageStyle *)style;

- (void)setSelectIndex:(NSInteger)index;

- (void)adjustIndicateViewX:(UIScrollView *)scrollView direction:(NSString *)direction;

@end
