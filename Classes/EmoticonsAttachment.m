//
//  EmoticonsAttachment.m
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/29.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import "EmoticonsAttachment.h"
#import "Emoticons.h"

@implementation EmoticonsAttachment

+ (NSAttributedString *)emotoconStringWithEmoticon:(Emoticons *)emoticon andFontHeight:(CGFloat)height{
    EmoticonsAttachment *attachment = [[EmoticonsAttachment alloc]init];
    attachment.image = [UIImage imageWithContentsOfFile:emoticon.imagePath];
    //设置图像高度
    attachment.bounds = CGRectMake(0, -4, height, height);
    attachment.chs = emoticon.chs;
    
    //返回属性文本
    return [NSAttributedString attributedStringWithAttachment:attachment];
}

@end
