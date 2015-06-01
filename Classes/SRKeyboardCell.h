//
//  SRKeyboardCell.h
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/30.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义表情图片的大小
#define EmoticonIconSize 32

@class Emoticons;

@interface SRKeyboardCell : UICollectionViewCell

@property (nonatomic, strong) Emoticons *emoticons;

@end
