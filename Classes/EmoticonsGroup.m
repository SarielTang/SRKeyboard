//
//  EmoticonsGroup.m
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/29.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import "EmoticonsGroup.h"
#import "Emoticons.h"

@interface EmoticonsGroup ()


@property (nonatomic, copy) NSString *emoticon_group_identifier;
@property (nonatomic, assign) int emoticon_group_type;
@property (nonatomic, copy) NSString *emoticon_group_path;

@end

@implementation EmoticonsGroup

+ (instancetype)emoticonsGroupWithDict:(NSDictionary *)dict{
    id instance = [[EmoticonsGroup alloc]init];
    [instance setValuesForKeysWithDictionary:dict];
    return instance;
}

///表情组的列表
+ (NSArray *)emoticonsGroups {
    //获取Emoticons.bundle下的路径
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"emoticons.plist" ofType:nil inDirectory:@"Emoticons.bundle"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //按照group的type类型进行排序
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        //注意:基本数据类型要进行数据转换
        return [[NSNumber numberWithInt:(int)obj2[@"emoticon_group_type"]] compare:[NSNumber numberWithInt:(int)obj1[@"emoticon_group_type"]]];
    }];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    [sortedArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[EmoticonsGroup emoticonsGroupWithDict:dict]];
    }];
    return arrayM;
}

///每个表情组中的表情列表
- (NSArray *)groupEmoticonsList{
    NSString *groupPath = [[[[NSBundle bundleForClass:[self class]] bundlePath] stringByAppendingPathComponent:@"Emoticons.bundle"] stringByAppendingPathComponent:self.emoticon_group_path];
    NSString *infoPath = [groupPath stringByAppendingPathComponent:@"info.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:infoPath];
    NSArray *array = dict[@"emoticon_group_emoticons"];
    /**
     表情数组需要满足以下条件
     
     - 每页需要 21 个表情
     - 每遍历 20 个表情插入一个删除按钮
     - 如果不足 20 需要插入空表情，以方便在 collectionView 中占位
     - 目标：每个分组的表情数量应该是 21 的整数倍
     */
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];

    __block int index = 0;
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[Emoticons emoticonsWithGroupName:self.emoticon_group_name GroupPath:groupPath AndDict:dict]];
        if (++index == 20) {
//            NSLog(@"---删除按钮---");
            //在当前表情组的最后生成一个删除按钮
            Emoticons *e = [Emoticons emoticonsWithGroupName:self.emoticon_group_name GroupPath:groupPath AndDict:nil];
            e.isRemoveButton = YES;
            [arrayM addObject:e];
            index = 0;
        }
    }];
    
    int emptyCount = arrayM.count % 21;
    if (emptyCount) {
//        NSLog(@"需要补足表情 %zd",emptyCount);
        
        //创建空表情
        for (int i = emptyCount; i < 21; i++) {
            Emoticons *e = [Emoticons emoticonsWithGroupName:self.emoticon_group_name GroupPath:groupPath AndDict:nil];
            [arrayM addObject:e];
        }
        //最后一个是删除按钮
        [arrayM.lastObject setIsRemoveButton:YES];
    }
    
    return arrayM;
}

@end
