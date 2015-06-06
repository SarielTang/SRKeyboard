//
//  EmoticonsAttachment.swift
//  01-表情键盘
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 heima. All rights reserved.
//

import UIKit

class EmoticonsAttachment: NSTextAttachment {
   
    /// 表情符号的文本
    var chs: String?
    
    /**
        `工厂`方法
    */
    class func emoticonString(emoticon: Emoticons, height: CGFloat) -> NSAttributedString {
    
        // 1. 创建图片附件属性文本
        let attachment = EmoticonsAttachment()
        
        attachment.image = UIImage(contentsOfFile: emoticon.imagePath!)
        // 设置图像高度
        attachment.bounds = CGRectMake(0, -4, height, height)
        attachment.chs = emoticon.chs
        
        // 2. 返回属性文本
        return NSAttributedString(attachment: attachment)
    }
}
