//
//  EmoticonsTextView.m
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/29.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import "EmoticonsTextView.h"
#import "Emoticons.h"
#import "EmoticonsAttachment.h"

@implementation EmoticonsTextView

//插入表情符号
- (void)insertEmoticon:(Emoticons *)emoticon {
    //判断是否是图片表情
    if (emoticon.chs) {
        //创建图片附件属性文本
        NSAttributedString *attrStr = [EmoticonsAttachment emotoconStringWithEmoticon:emoticon andFontHeight:self.font.lineHeight];
        //将文本添加到 textView
        NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
        [textStr replaceCharactersInRange:self.selectedRange withAttributedString:attrStr];
        [textStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textStr.length)];
        NSRange range = self.selectedRange;
        self.attributedText = textStr;
        self.selectedRange = NSMakeRange(range.location + 1, 0);
    }else if (emoticon.emojiStr != nil) {
        //将 emoji 字符串插入textView
        [self replaceRange:self.selectedTextRange withText:emoticon.emojiStr];
    }
}

@end
