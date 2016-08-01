//
//  CollectionViewCell.m
//  UICollectionViewCell的移动
//
//  Created by 程金伟 on 16/7/18.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加内部控件
        //imageview
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        //btn
        _btnDelete = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnDelete.frame = CGRectMake(totalWidth-20, 0, 20, 20);
        _btnDelete.backgroundColor = [UIColor blueColor];
        [_btnDelete setTitle:@"X" forState:UIControlStateNormal];
        [self addSubview:_btnDelete];
        
        //lable
        _lable = [[UILabel alloc] init];
        _lable.font = [UIFont systemFontOfSize:14];
        _lable.frame = CGRectMake(0, 0, totalWidth, totalHeight);
        _lable.layer.borderColor = [[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] CGColor];
        _lable.layer.borderWidth = 0.5f;
        _lable.tintColor = [UIColor redColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lable];
    }
    return self;
}


@end
