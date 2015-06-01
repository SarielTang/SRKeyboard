//
//  EmoticonsGroup.h
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/29.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmoticonsGroup : NSObject

@property (nonatomic, copy) NSString *emoticon_group_name;

+ (instancetype)emoticonsGroupWithDict:(NSDictionary *)dict;

///表情组的列表
+ (NSArray *)emoticonsGroups;

///每个表情组中的表情列表
- (NSArray *)groupEmoticonsList;

@end
