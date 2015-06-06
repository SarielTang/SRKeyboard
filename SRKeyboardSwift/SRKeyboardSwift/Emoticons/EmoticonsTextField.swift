//
//  EmoticonsTextField.swift
//  01-表情键盘
//
//  Created by xl_bin on 15/5/28.
//  Copyright (c) 2015年 heima. All rights reserved.
//

import UIKit

class EmoticonsTextField: UITextField {

//    init(frame: CGRect) {
//        <#code#>
//    }
    
    /// 插入表情符号
    func insertEmoticon(emoticon: Emoticons) {
        // 1. 判断是否是图片表情
        if emoticon.chs != nil {
            replaceRange(selectedTextRange!, withText: emoticon.chs!)
        } else if emoticon.emojiStr != nil {
            // 将 emoji 字符串插入的 textView
            replaceRange(selectedTextRange!, withText: emoticon.emojiStr!)
        }
    }
}
