//
//  Emoticons.h
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/28.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emoticons : NSObject

/// 表情文本
@property (nonatomic, copy) NSString *chs;
/// 是否删除按钮标记
@property (nonatomic, assign) BOOL isRemoveButton;
/// 图像路径
@property (nonatomic, copy) NSString *imagePath;
/// emoji 字符串
@property (nonatomic, copy) NSString *emojiStr;

+ (instancetype)emoticonsWithGroupName:(NSString *)groupName GroupPath:(NSString *)groupPath AndDict:(NSDictionary *)dict;

+ (NSArray *)emoticonsList;

@end
