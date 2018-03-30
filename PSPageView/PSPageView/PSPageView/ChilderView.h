//
//  ChilderView.h
//  PSPageView
//
//  Created by mac on 2018/3/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChilderViewDelegate <NSObject>

//- (void)clickGoodsWithIndex:(NSInteger)index
//     withMerchantGoodsModel:(MerchantGoodsModel *)model;

@end

@interface ChilderView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

@property (nonatomic, weak) id <ChilderViewDelegate>delegate;

@end
