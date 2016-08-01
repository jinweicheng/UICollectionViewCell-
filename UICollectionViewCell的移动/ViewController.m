//
//  ViewController.m
//  UICollectionViewCell的移动
//
//  Created by 程金伟 on 16/7/18.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "ViewController.h"

#import "CollectionViewCell.h"

#import "model.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//@property (nonatomic, strong) CALayer *dotLayer;
//@property (nonatomic, assign) CGFloat endPoint_x;
//@property (nonatomic, assign) CGFloat endPoint_y;
//@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@end

@implementation ViewController
//懒加载
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        
        
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);//分区内边距
        
        CGFloat totalWidth = kWidth-40;
        CGFloat itemWidth = (totalWidth)/3.0;
        CGFloat itemHeght = 33;
        //注意：item的宽高必须要提前算好
        _flowLayout.itemSize = CGSizeMake(itemWidth, itemHeght);
        //创建collectionView对象，并赋值布局
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kWidth, kHeight - 20) collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentiifer"];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.array = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4",
                  @"5", @"6", @"7", @"8",
                  @"9", @"10", @"11", @"12",@"13", @"14", @"15", @"16",
                  @"17", @"18", @"19", @"20",  nil];
	
	_longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
	[self.collectionView addGestureRecognizer:_longPress];
    
    [self.view addSubview:self.collectionView];
	
}

//长按手势
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    
    switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
				NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
				// 找到当前的cell
				CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
				// 定义cell的时候btn是隐藏的, 在这里设置为NO
				[cell.btnDelete setHidden:NO];
				
                cell.btnDelete.tag = selectIndexPath.item;
				
				//添加删除的点击事件
                [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
				
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            break;
        }
        default: [self.collectionView cancelInteractiveMovement];
            break;
    }
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
    // 找到当前的cell
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
    cell.btnDelete.hidden = YES;
	
	/*1.存在的问题,移动是二个一个移动的效果*/
	//	[collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
	/*2.存在的问题：只是交换而不是移动的效果*/
//    [self.array exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
	/*3.完整的解决效果*/
	//取出源item数据
	id objc = [self.array objectAtIndex:sourceIndexPath.item];
	//从资源数组中移除该数据
	[self.array removeObject:objc];
	//将数据插入到资源数组中的目标位置上
	[self.array insertObject:objc atIndex:destinationIndexPath.item];

	
    [self.collectionView reloadData];
}


#pragma mark---UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentiifer" forIndexPath:indexPath];
	
//    _longPress.view.tag = indexPath.item;
    //设置cell
//    model *mode = [[model alloc] init];
//    mode = self.array[indexPath.section][indexPath.item];
    //        cell.model = model;
    cell.lable.text = self.array[indexPath.item];
    
    cell.btnDelete.hidden = YES;
	
    return cell;
}


#pragma mark---UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.array[indexPath.item]);
}


#pragma mark---btn的删除cell事件

- (void)btnDelete:(UIButton *)btn{
	
	//cell的隐藏删除设置
	NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
	// 找到当前的cell
	CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
	cell.btnDelete.hidden = NO;
	
	//取出源item数据
	id objc = [self.array objectAtIndex:btn.tag];
	//从资源数组中移除该数据
	[self.array removeObject:objc];
	
	[self.collectionView reloadData];
	
}
@end
