//
//  PSPageContentView.m
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PSPageContentView.h"
#import "PSPageStyle.h"
#import "PSPageTitleView.h"
#import "PSPageCollectionViewFlowLayout.h"

#define CellID  @"CellID"

@interface PSPageContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,PSPageReloadable,PSPageTitleViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation PSPageContentView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _startOffsetX = 0;
        self.childViewControllers = [NSMutableArray array];
        self.style = [[PSPageStyle alloc] init];
        self.titles = [NSMutableArray array];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame withStyle:(PSPageStyle *)style withChildViewControllers:(NSMutableArray *)childViewControllers withStartIndex:(NSInteger)startIndex withTitles:(NSMutableArray *)titles{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.childViewControllers = childViewControllers;
        self.style = style;
        self.titles = titles;
        _startIndex = startIndex;
        //UI相关设置
        [self setBaseUI];
        //布局相关
        [self layOutViews];
    }
    return self;
}

#pragma mark ==================UI相关设置==================
- (void)setBaseUI {
    
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = self.style.contentViewBackgroundColor;
    self.collectionView.scrollEnabled = self.style.isContentScrollEnable;
    //指定代理
    self.reloader = self.childViewControllers[_startIndex];
     [self.reloader contentViewScrollViewCurrentIndex:_startIndex withTitles:self.titles withViewController:self.childViewControllers[_startIndex]];
}
#pragma mark ==================布局相关设置==================
- (void)layOutViews {
    
    self.collectionView.frame = self.bounds;
    PSPageCollectionViewFlowLayout *layout = (PSPageCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = self.bounds.size;
    layout.offset = _startIndex * self.bounds.size.width;
}
#pragma mark ==================UICollectionView代理方法==================
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.childViewControllers.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    //先移除子视图
    for (UIView *subView in cell.contentView.subviews) {
        
        [subView removeFromSuperview];
    }
    
    UIViewController *vc = self.childViewControllers[indexPath.item];
    self.reloader = self.childViewControllers[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    return cell;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.isForbidDelegate = NO;
    _startOffsetX = scrollView.contentOffset.x;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self updateUIWithScrollView:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        
        [self collectionViewDidEndScroll:scrollView];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
     [self collectionViewDidEndScroll:scrollView];
}
- (void)collectionViewDidEndScroll:(UIScrollView *)scrollView {
    
    NSInteger inIndex = (NSInteger)(self.collectionView.contentOffset.x / self.collectionView.bounds.size.width);
    
    self.reloader = self.childViewControllers[inIndex];
    
    [self.reloader contentViewDidEndScroll];
    
    [self.reloader contentViewScrollViewCurrentIndex:inIndex withTitles:self.titles withViewController:self.childViewControllers[inIndex]];
    
    [self.delegate contentViewWithIndex:inIndex withContentView:self];
    
}
#pragma mark ==================更新UI==================
- (void)updateUIWithScrollView:(UIScrollView *)scrollView {
    
    if (self.isForbidDelegate) {
        
        return;
    }
    CGFloat progress = 0.0;
    NSInteger targetIndex = 0;
    NSInteger sourceIndex = 0;
    
    //控制偏移量在一个屏幕的范围内
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
    if (self.collectionView.contentOffset.x > _startOffsetX) {
        //向左滑动
        if (self.collectionView.contentOffset.x < [UIScreen mainScreen].bounds.size.width) {
            
            sourceIndex = index;
            targetIndex = index + 1;
        }else{
            
            sourceIndex = index - 1;
            targetIndex = index;
        }
        if (targetIndex > self.childViewControllers.count - 1) {
            return;
        }
    } else {
        //向右滑动
        sourceIndex = index + 1;
        targetIndex = index;
        progress = 1 - progress;
        if (targetIndex < 0) {
            return;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentViewWithSourceIndex:withTargetIndex:withContentView:)]) {
        
        [self.delegate contentViewWithSourceIndex:sourceIndex withTargetIndex:targetIndex withContentView:self];
    }
}
#pragma mark ==================协议代理==================
- (void)clickTitleView:(PSPageTitleView *)titleView withIndex:(NSInteger)currentIndex {
    
    self.isForbidDelegate = YES;
    
    if (currentIndex > self.childViewControllers.count - 1) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
    [self.reloader clickTitleWithIndex:indexPath.row withTitles:self.titles withViewController:self.childViewControllers[indexPath.row]];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
}

#pragma mark ==================懒加载==================
-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        PSPageCollectionViewFlowLayout *layout = [[PSPageCollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        if (@available(iOS 10.0, *)) {
            
            _collectionView.prefetchingEnabled = NO;
        }
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
    }
    return _collectionView;
}

@end
