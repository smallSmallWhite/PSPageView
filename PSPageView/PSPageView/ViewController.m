//
//  ViewController.m
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "PSPageStyle.h"
#import "PSPageView.h"
#import "ContentViewController.h"
#import "ZXCategorySliderBar.h"
#import "CategoriesModel.h"
#import "ZXPageStyle.h"
#import "ZXPageCollectionView.h"
#import "ChilderView.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
//状态栏的高度
#define kApplicationStatusBarHeight  [UIApplication sharedApplication].statusBarFrame.size.height

@interface ViewController ()<ZXCategorySliderBarDelegate,ZXPageCollectionViewDelegate,ZXPageCollectionViewDataSource>


@property (nonatomic,strong) ZXCategorySliderBar *sliderBar;
@property (nonatomic,strong) ZXPageCollectionView *pageVC;
@property (nonatomic,strong) NSMutableArray *categoriesArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //滚动视图相关配置
//    PSPageStyle *style = [[PSPageStyle alloc] init];
//    style.isTitleScrollEnable = NO;
//    style.isScaleEnable = NO;
//    style.titleViewHeight = 50;
//    style.isShowBottomLine = YES;
//
//    NSMutableArray *titles = [NSMutableArray arrayWithObjects:@"全部", @"待付款", @"待收货", @"已完成", @"已取消" , nil];
//
//    //创建每一页对应的Controller
//    NSMutableArray *childViewControllers = [NSMutableArray array];
//    for (int i = 0; i < titles.count; i++) {
//
//        ContentViewController *vc = [[ContentViewController alloc] init];
//        vc.view.backgroundColor = [UIColor grayColor];
////        [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
//        [childViewControllers addObject:vc];
//    }
//    CGSize size = [UIScreen mainScreen].bounds.size;
//
//    // 创建对应的DNSPageView，并设置它的frame
//    PSPageView *pageView = [[PSPageView alloc] initWithFrame:CGRectMake(0, 84, size.width, size.height) style:style titles:titles childViewControllers:childViewControllers withCurrentIndex:4];
//    [self.view addSubview:pageView];
    
    self.sliderBar.originIndex = 0;
    self.sliderBar.itemArray = self.categoriesArray;
    [self.view addSubview:self.sliderBar];
    [self.view addSubview:self.pageVC];
    
    
    
}

- (NSInteger)numberOfItemsInZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView{
    return self.categoriesArray.count;
}

- (void)ZXPageViewDidScroll:(UIScrollView *)scrollView direction:(NSString *)direction{
    [self.sliderBar adjustIndicateViewX:scrollView direction:direction];
}

- (UIView *)ZXPageCollectionView:(ZXPageCollectionView *)ZXPageCollectionView
              viewForItemAtIndex:(NSInteger)index{
    NSString *reuseIdentifier = [NSString stringWithFormat:@"childView%ld", (long)index];
    ChilderView *childView1 = (ChilderView *)[ZXPageCollectionView dequeueReuseViewWithReuseIdentifier:reuseIdentifier forIndex:index];
    if (!childView1) {
        childView1 = [[ChilderView alloc]initWithFrame:CGRectMake(0, 0, ZXPageCollectionView.frame.size.width, ZXPageCollectionView.frame.size.height)];
        childView1.tag = 8000 + index;
        childView1.reuseIdentifier = reuseIdentifier;
    }
    childView1.delegate = self;
    childView1.dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    return childView1;
}

- (void)ZXPageViewDidEndChangeIndex:(ZXPageCollectionView *)pageView currentView:(UIView *)view{
    
    //请求某一分类下的数据
    [self.sliderBar setSelectIndex:pageView.currentIndex];
   
}

- (void)ZXPageViewWillBeginDragging:(ZXPageCollectionView *)pageView
{
    self.sliderBar.isMoniteScroll = YES;
    self.sliderBar.scrollViewLastContentOffset = pageView.mainScrollView.contentOffset.x;
}

- (void)didSelectedIndex:(NSInteger)index{
    //请求某一分类下的数据
    [self.pageVC moveToIndex:index animation:YES];
    
}
#pragma mark ==================懒加载==================
- (ZXCategorySliderBar *)sliderBar
{
    if (!_sliderBar) {
        ZXPageStyle *style = [[ZXPageStyle alloc] init];
        style.titleFontSize = 15;
        style.isTitleScrollEnable = NO;
        style.titleSelectedColor = [UIColor redColor];
        style.titleColor = [UIColor blackColor];
        style.bottomLineColor = [UIColor redColor];
        _sliderBar = [[ZXCategorySliderBar alloc]initWithFrame:CGRectMake(0, 44 + kApplicationStatusBarHeight, screenW, 55) withStyle:style];
        _sliderBar.delegate = self;
    }
    return _sliderBar;
}
- (ZXPageCollectionView *)pageVC
{
    if (!_pageVC) {
        _pageVC = [[ZXPageCollectionView alloc]initWithFrame:CGRectMake(0, 44 + kApplicationStatusBarHeight + 55, screenW, screenH - 64 - 55)];
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        _pageVC.mainScrollView.bounces = NO;
    }
    return _pageVC;
}
-(NSMutableArray *)categoriesArray {
    
    if (!_categoriesArray) {
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部",@"待收货",@"已收获",@"已取消",@"一确定", nil];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            
            CategoriesModel *model = [[CategoriesModel alloc] init];
            model.name = array[i];
            [tempArray addObject:model];
        }
        _categoriesArray = [NSMutableArray arrayWithArray:tempArray];
    }
    return _categoriesArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
