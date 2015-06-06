//
//  Emoticons.swift
//  01-表情键盘
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 heima. All rights reserved.
//

import UIKit

class Emoticons: NSObject {
   
    /// 分组名称
    var emoticon_group_name: String?
    /// 分组路径
    var emoticon_group_path: String?
    /// 表情文本
    var chs: String?
    /// 图片名称
    var png: String?
    /// emoji 代码
    var code: String?
    /// 是否删除按钮标记
    var isRemoveButton = false
    
    /// 图像路径
    var imagePath: String? {
        // 判断是否有图像
        if png != nil {
            return emoticon_group_path!.stringByAppendingPathComponent(png!)
        }
        return nil
    }
    
    /// emoji 字符串
    var emojiStr: String?
    
    init(groupName: String, groupPath: String, dict:[String: String]?) {
        super.init()

        emoticon_group_name = groupName
        emoticon_group_path = groupPath

        chs = dict?["chs"]
        png = dict?["png"]
        code = dict?["code"]
        
        if code != nil {
            // scanner 是专门用来扫描字符串的
            let scanner = NSScanner(string: code!)
            // 扫描其中的16进制数字
            // 提示：scanner 的扫描结果会输出到 result，不能使用 let
            var result: UInt32 = 0
            scanner.scanHexInt(&result)
            
            emojiStr = "\(Character(UnicodeScalar(result)))"
        }
    }
    
    /// 返回所有的表情符号数组
    class func emoticonsList() -> [Emoticons] {
        
        var list = [Emoticons]()
        
        // 2. 遍历表情分组的数组
        for group in EmoticonsGroup.EmoticonGroups() {
            // 将所有的表情分组加载
            
            list += group.groupEmoticonsList()
        }
        
        return list
    }
}
