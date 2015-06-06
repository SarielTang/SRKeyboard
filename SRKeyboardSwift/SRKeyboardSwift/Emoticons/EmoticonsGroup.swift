//
//  EmoticonsGroup.swift
//  01-表情键盘
//
//  Created by xl_bin on 15/5/27.
//  Copyright (c) 2015年 heima. All rights reserved.
//

import UIKit

/*
<key>emoticon_group_name</key>
<string>默认</string>
<key>emoticon_group_identifier</key>
<string>com.sina.default</string>
<key>emoticon_group_type</key>
<string>3</string>
<key>emoticon_group_path</key>
<string>default</string>
*/

class EmoticonsGroup: NSObject {
    let emoticon_group_name:String?
    let emoticon_group_identifier:String?
    var emoticon_group_type:Int = 0
    var emoticon_group_path:String?
    
    init(dict: [String:String]?) {
        emoticon_group_name = dict?["emoticon_group_name"]
        emoticon_group_identifier = dict?["emoticon_group_identifier"]
        emoticon_group_path = dict?["emoticon_group_path"]
        emoticon_group_type = dict?["emoticon_group_type"]!.toInt() ?? 0
    }
    
    ///取得根据grouptype进行排序得到的数组
    class func EmoticonGroups() -> [EmoticonsGroup] {
        // 1. 加载 emoticons.plist（分组名&分组路径）
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        let array = (NSArray(contentsOfFile: path!) as! [[String: String]]).sorted { (dict1, dict2) -> Bool in
            return dict1["emoticon_group_type"] < dict2["emoticon_group_type"]
        }
        var arrayM = [EmoticonsGroup]()
        for dict in array {
            arrayM.append(EmoticonsGroup(dict: dict))
        }
        return arrayM
    }
    
    ///获取本组的所有表情数组
    func groupEmoticonsList() -> [Emoticons] {
        // 因为：bundle是固定的，是会随着程序一起打包的
        // 如果运行的时候，程序崩溃，程序员就应该第一时间修改，而不用使用 let 判断
        let groupPath = NSBundle.mainBundle().bundlePath.stringByAppendingPathComponent("Emoticons.bundle").stringByAppendingPathComponent(emoticon_group_path!)
        let infoPath = groupPath.stringByAppendingPathComponent("info.plist")
        let dict = NSDictionary(contentsOfFile: infoPath)!
        // 取出表情符号数组
        let array = dict["emoticon_group_emoticons"] as! [[String: String]]
        /**
        表情数组需要满足以下条件
        
        - 每页需要 21 个表情
        - 每遍历 20 个表情插入一个删除按钮
        - 如果不足 20 需要插入空表情，以方便在 collectionView 中占位
        - 目标：每个分组的表情数量应该是 21 的整数倍
        */
        var count = 0
        var list = [Emoticons]()
        for dict in array {
            println(dict)
            
            list.append(Emoticons(groupName: emoticon_group_name!, groupPath: groupPath, dict: dict))
            
            count++
            if count == 20 {
                // 生成一个删除的表情
                let e = Emoticons(groupName: emoticon_group_name!, groupPath: groupPath, dict: nil)
                e.isRemoveButton = true
                
                list.append(e)
                count = 0
            }
        }
        
        // 如果当前数组不能被21整除，需要补足空表情
        var emptyCount = list.count % 21
        if emptyCount != 0 {
            println("需要补足表情 \(emptyCount)")
            
            // 创建空表情
            for i in emptyCount..<21 {
                let e = Emoticons(groupName: emoticon_group_name!, groupPath: groupPath, dict: nil)
                
                list.append(e)
            }
            // 最后一个是删除按钮
            list.last?.isRemoveButton = true
        }

        return list
    }
}
