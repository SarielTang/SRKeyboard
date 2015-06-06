//
//  EmoticonsTextView.swift
//  01-表情键盘
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 heima. All rights reserved.
//

import UIKit

class EmoticonsTextView: UITextView {

    /// 插入表情符号
    func insertEmoticon(emoticon: Emoticons) {
        // 1. 判断是否是图片表情
        if emoticon.chs != nil {
            // 1. 创建图片附件属性文本
            let attrStr = EmoticonsAttachment.emoticonString(emoticon, height: font.lineHeight)
            
            // 2. 将文本添加到 textView
            // 1> 从 textView 拿出可变的文本
            var textStr = NSMutableAttributedString(attributedString: attributedText)
            // 2> 追加文本
            textStr.replaceCharactersInRange(selectedRange, withAttributedString: attrStr)
            
            // 3> 重新添加整个文本的属性
            /**
            name 是文本属性的名字
            value 是文本属性的值
            */
            textStr.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, textStr.length))
            
            // 4> 记录当前用户选中的光标位置
            let range = selectedRange
            
            // 5> 设置文本，替换了 textView 的所有属性文本
            attributedText = textStr
            
            // 6> 恢复光标位置
            selectedRange = NSMakeRange(range.location + 1, 0)
        } else if emoticon.emojiStr != nil {
            // 将 emoji 字符串插入的 textView
            replaceRange(selectedTextRange!, withText: emoticon.emojiStr!)
        }
    }
    
    /// 返回文本框中的完整文本
    func fullText() -> String {
        let attrStr = attributedText
        var strM = String()
        
        attributedText.enumerateAttributesInRange(NSMakeRange(0, attrStr.length), options: NSAttributedStringEnumerationOptions(0)) { (dict, range, _) in
            
            // 通过跟踪，能够发现，如果有 NSAttachment 说明是图片，否则是文本
            // 需要解决一个问题：从 NSAttachment 中获取到表情文字
            if let attachment = dict["NSAttachment"] as? EmoticonsAttachment {
                println("有图片 \(attachment.chs)")
                strM += attachment.chs!
            } else {
                let str = (attrStr.string as NSString).substringWithRange(range)
                println("---\(str)")
                strM += str
            }
        }
        
        return strM
    }
}
