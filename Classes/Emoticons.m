//
//  Emoticons.m
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/28.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import "Emoticons.h"
#import "EmoticonsGroup.h"

@interface Emoticons ()

/// 分组名称
@property (nonatomic, copy) NSString *emoticon_group_name;
/// 分组路径
@property (nonatomic, copy) NSString *emoticon_group_path;
/// 图片名称
@property (nonatomic, copy) NSString *png;
/// emoji 代码
@property (nonatomic, copy) NSString *code;


@end

@implementation Emoticons

- (NSString *)imagePath{
    //判断是否有图像
    if (self.png != nil) {
        return [self.emoticon_group_path stringByAppendingPathComponent:self.png];
    }
    return nil;
}

+ (instancetype)emoticonsWithGroupName:(NSString *)groupName GroupPath:(NSString *)groupPath AndDict:(NSDictionary *)dict{
    Emoticons *instance = [[Emoticons alloc]init];
    
    instance.emoticon_group_name = groupName;
    instance.emoticon_group_path = groupPath;
    instance.chs = dict[@"chs"];
    instance.png = dict[@"png"];
    instance.code = dict[@"code"];
    
    if (instance.code != nil) {
        NSScanner *scanner = [[NSScanner alloc]initWithString:instance.code];
        unsigned int result = 0;
        [scanner scanHexInt:&result];
//        instance.emojiStr = [NSString stringWithFormat:@"%C",(unichar)result];
        instance.emojiStr = [[NSString alloc]initWithBytes:&result length:sizeof(result) encoding:NSUTF32LittleEndianStringEncoding];
    }
    return instance;
}

+ (NSArray *)emoticonsList{
    NSMutableArray *arrayM = [NSMutableArray array];
    // 遍历表情分组的数组
    NSArray *groups = [EmoticonsGroup emoticonsGroups];
    for (int i = 0; i < groups.count; i++) {
        EmoticonsGroup *group = groups[i];
        [arrayM addObjectsFromArray:group.groupEmoticonsList];
    }

    return arrayM;
}

@end
