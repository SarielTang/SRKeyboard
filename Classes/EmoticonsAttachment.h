//
//  EmoticonsAttachment.h
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/29.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emoticons;

@interface EmoticonsAttachment : NSTextAttachment

///表情符号的文本
@property (nonatomic, copy) NSString *chs;

///返回属性文本
+ (NSAttributedString *)emotoconStringWithEmoticon:(Emoticons *)emoticon andFontHeight:(CGFloat)height;

@end
