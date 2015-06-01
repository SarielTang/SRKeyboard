//
//  SRKeyboard.h
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/28.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义可重用cell的ID
#define SRKeyboardCellID @"SRKeyboardCellID"

@class Emoticons;
@interface SRKeyboardController : UIViewController

- (instancetype)initWithEmoticonBlock:(void (^)(Emoticons *emoticons)) selectedEmoticon;

@end
