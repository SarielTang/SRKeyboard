//
//  EmoticonsTextView.h
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/29.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emoticons;
@interface EmoticonsTextView : UITextView

- (void)insertEmoticon:(Emoticons *)emoticon;

@end
