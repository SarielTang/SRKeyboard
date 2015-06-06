//
//  ViewController.swift
//  SRKeyboardSwift
//
//  Created by xl_bin on 15/6/6.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: EmoticonsTextView!
    @IBOutlet weak var textField: EmoticonsTextField!
    
    // 控制器对 keyboardVC 是强引用
    lazy var keyboadVC: EmoticonKeyboardViewController = {
        // 闭包中会对 self 强引用
        weak var weakSelf = self
        return EmoticonKeyboardViewController(selectedEmoticon: { (emoticon) -> () in
            // 调用方法，同样会产生强引用，在 OC 中同样需要注意
            weakSelf?.textView?.insertEmoticon(emoticon)
            weakSelf?.textField?.insertEmoticon(emoticon)
        })
        }()
    
    deinit {
        println("88")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 UI
        setupUI()
    }
    
    private func setupUI() {
        // 1. 添加子控制器
        addChildViewController(keyboadVC)
        
        // 2. 设置 textView 输入视图 - 键盘的视图
        textView?.inputView = keyboadVC.view
        textField?.inputView = keyboadVC.view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func show(sender: AnyObject) {
        
        println(self.textView.fullText())
    }

}

