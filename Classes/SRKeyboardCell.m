//
//  SRKeyboardCell.m
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/30.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import "SRKeyboardCell.h"
#import "Emoticons.h"

///Cell类
@interface SRKeyboardCell()

@property (nonatomic, strong) UIButton *emoticonsButton;

@end

@implementation SRKeyboardCell

- (UIButton *)emoticonsButton{
    if (_emoticonsButton == nil) {
        _emoticonsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emoticonsButton.frame = CGRectInset(self.bounds, 4, 4);
        _emoticonsButton.backgroundColor = [UIColor whiteColor];
        //指定文本的字体与图像的大小一致
        _emoticonsButton.titleLabel.font = [UIFont systemFontOfSize:EmoticonIconSize];
        //取消 button 的用户交互,就能够用 collectionView 的代理方法拦截
        _emoticonsButton.userInteractionEnabled = NO;
        [self addSubview:_emoticonsButton];
    }
    return _emoticonsButton;
}

- (void)setEmoticons:(Emoticons *)emoticons{
    _emoticons = emoticons;
    //设置图像
    if (emoticons.imagePath) {
        [self.emoticonsButton setImage:[UIImage imageWithContentsOfFile:emoticons.imagePath] forState:UIControlStateNormal];
    }else {
        [self.emoticonsButton setImage:nil forState:UIControlStateNormal];
    }
    //设置emoji
    [self.emoticonsButton setTitle:emoticons.emojiStr forState:UIControlStateNormal];
    //删除按钮
    if (emoticons.isRemoveButton) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"Emoticons" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        
        [self.emoticonsButton setImage:[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"compose_emotion_delete@2x" ofType:@"png"]]forState:UIControlStateNormal];
        [self.emoticonsButton setImage:[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"compose_emotion_delete_highlighted@2x" ofType:@"png"]] forState:UIControlStateNormal];
    }
}

@end
