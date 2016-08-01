//
//  model.h
//  UICollectionViewCell的移动
//
//  Created by 程金伟 on 16/7/18.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface model : NSObject
@property (nonatomic,copy)NSString *string;
@property (nonatomic,copy)NSString *btnDeleteStr;
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;
@end
