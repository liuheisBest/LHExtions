//
//  BaseCollectionViewController.m
//  PBOA
//
//  Created by 刘贺 on 16/12/5.
//  Copyright © 2016年 com.poba. All rights reserved.
//  https://github.com/liuheisBest/LHExtions
//

#import "BaseCollectionViewController.h"
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
@interface BaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation BaseCollectionViewController
static NSString * reuseIdentifier = @"hehe";
- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //设置流水布局的大小
        CGFloat cellWith =([UIScreen mainScreen].bounds.size.width)/3.0;
        flowLayout.itemSize = CGSizeMake(cellWith , cellWith);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _flowLayout = flowLayout;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:self.flowLayout];
        /**
         *默认是YES ,设置为NO之后就不在滚动,不会出现上下拉刷新
         */
        collectionView.scrollEnabled = YES;
        collectionView.translatesAutoresizingMaskIntoConstraints = YES;
        [self.view addSubview:collectionView];
        collectionView.collectionViewLayout = self.flowLayout;
        collectionView.delegate =self;
        collectionView.dataSource =self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNO = 1;
    self.pageSize = 15;
    [self.view addSubview:self.collectionView];

}
- (void)setIsOpenHeaderRefresh:(BOOL)isOpenHeaderRefresh{
    if (_isOpenHeaderRefresh != isOpenHeaderRefresh) {
        _isOpenHeaderRefresh = isOpenHeaderRefresh;
        WeakSelf(self);
        if (isOpenHeaderRefresh) {
            self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                // 增加5条假数据
                weakSelf.pageNO = 1;
                [weakSelf headerRequestWithData];
                // 结束刷新
                [weakSelf.collectionView.mj_header endRefreshing];
                
            }];
            [self.collectionView.mj_header beginRefreshing];
        
        }
    }
}
//下拉刷新
- (void)setIsOpenFooterRefresh:(BOOL)isOpenFooterRefresh{
    if (_isOpenFooterRefresh != isOpenFooterRefresh) {
        _isOpenFooterRefresh = isOpenFooterRefresh;
        WeakSelf(self);
        if (isOpenFooterRefresh) {
            // 上拉刷新
            self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                // 增加5条假数据
                weakSelf.pageNO ++;
                [weakSelf footerRequestWithData];
                // 结束刷新
                [weakSelf.collectionView.mj_footer endRefreshing];
            }];
        }
    }
}
//头部刷新请求 (子类需要重写)
- (void)headerRequestWithData{
    
}
//脚部刷新
- (void)footerRequestWithData{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.dataArray[indexPath.row];
    
    return cell;
}


//- (UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
//
//{
//    return UIEdgeInsetsMake (10,10,0,10);
//}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
