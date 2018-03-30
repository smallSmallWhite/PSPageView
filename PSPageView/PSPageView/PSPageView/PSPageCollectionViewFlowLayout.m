//
//  PSPageCollectionViewFlowLayout.m
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PSPageCollectionViewFlowLayout.h"

@implementation PSPageCollectionViewFlowLayout

-(void)prepareLayout {
    
    [super prepareLayout];
    [self.collectionView setContentOffset:CGPointMake(_offset, 0)];
}


@end
