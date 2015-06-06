//
//  EmoticonKeyboardViewController.swift
//  01-表情键盘
//
//  Created by apple on 15/5/23.
//  Copyright (c) 2015年 heima. All rights reserved.
//

import UIKit

/**
    UI 组成 : UICollectionView + ToolBar

    自定义键盘的 frame 是需要考虑的
    */
private var cellIdentifier = "cellIdentifier"

class EmoticonKeyboardViewController: UIViewController {

    /// 选中表情回调闭包
    var selectedEmoticon: ((emoticon: Emoticons)->())?
    
    /// 实例化键盘控制器，并且指定选中表情的回调
    init(selectedEmoticon: (emoticon: Emoticons)->()) {
        super.init(nibName: nil, bundle: nil)
        
        // 记录闭包
        self.selectedEmoticon = selectedEmoticon
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        println("keyboard VC 88")
    }
    
    /// 表情数组
    lazy var emoticonsList: [Emoticons] = {
        return Emoticons.emoticonsList()
    }()
    

    lazy var toolBar: UIToolbar = {
       
        let tool = UIToolbar(frame: CGRectZero)
        
        // 添加 item
        var items = [AnyObject]()
        var index = 0
        var pageIndex = 0
        let array = EmoticonsGroup.EmoticonGroups()
        for group in array {
            let str = group.emoticon_group_name
            let bar = UIBarButtonItem(title: str, style: UIBarButtonItemStyle.Plain, target: self, action: "selectItem:")
            ///根据每组的表情数目进行toolbar的布局.
            bar.tag = pageIndex
            pageIndex += (group.groupEmoticonsList().count / 21)
            
//            println("\(str)--\(pageIndex)--\((group.groupEmoticonsList().count / 21))")
            
            items.append(bar)
            
            if ++index < array.count {
                items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
            }
        }
        tool.items = items
        tool.tintColor = UIColor.darkGrayColor()
        
        return tool
    }()
    
    // 因为所有的东西都是在bundle中的，此处可以适当偷懒，可以想更好的办法
    func selectItem(item: UIBarButtonItem) {
        
        println("----\(item.tag)")
        
        let indexPath = NSIndexPath(forItem: item.tag * 21, inSection: 0)
        
        // 滚动到对应的 indexPath
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
    }
    
    /// 表情集合视图
    lazy var collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        
        let w = UIScreen.mainScreen().bounds.width / 7
        layout.itemSize = CGSizeMake(w, w)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(4, 0, 0, 0)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let cv = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        cv.pagingEnabled = true
        
        cv.dataSource = self
        cv.delegate = self
        
        // 注册原型cell
        cv.registerClass(EmoticonCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        return cv
    }()
    
    override func loadView() {
        // 执行系统默认的方法创建 view
        super.loadView()
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(toolBar)
        view.addSubview(collectionView)
        
        // 设置自动布局
        toolBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var cons = [AnyObject]()
        
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["collectionView": collectionView])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolBar]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["toolBar": toolBar])
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-[toolBar(44)]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["toolBar": toolBar, "collectionView": collectionView])
        
        view.addConstraints(cons)
    }
    
//    override func loadView() {
//        view = UIView(frame: UIScreen.mainScreen().bounds)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor()
    }
}

/**
    要交互的控件，最好保证有 40 个点，再小就不好交互了
*/
extension EmoticonKeyboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath)
        // 根据 indexPath 取到用户选中的表情
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? EmoticonCell {
            // 闭包回调
            self.selectedEmoticon!(emoticon: cell.emoticons!)
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return emoticonsList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! EmoticonCell
        
        cell.emoticons = emoticonsList[indexPath.item]
        
        return cell
    }
}

class EmoticonCell: UICollectionViewCell {
    
    // 表情模型
    var emoticons: Emoticons? {
        didSet {
            // 1. 设置图像
            if emoticons?.imagePath != nil {
                emoticonButton.setImage(UIImage(contentsOfFile: emoticons!.imagePath!), forState: UIControlState.Normal)
            } else {
                emoticonButton.setImage(nil, forState: UIControlState.Normal)
            }
            
            // 2. emoji
            emoticonButton.setTitle(emoticons?.emojiStr ?? "", forState: UIControlState.Normal)
            
            // 3. 删除按钮
            if emoticons!.isRemoveButton {
                emoticonButton.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
                emoticonButton.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
            }
        }
    }
    
    var emoticonButton = UIButton()
    
    // frame 就是 cell 的准确大小
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        println(frame)
        // 设置按钮大小
        emoticonButton.frame = CGRectInset(bounds, 4, 4)
        emoticonButton.backgroundColor = UIColor.whiteColor()
        
        // 指定文本的字体大小与图像大小一致
        emoticonButton.titleLabel?.font = UIFont.systemFontOfSize(32)
        
        // 取消 button 的用户交互，就能够用 collevtionView 的代理方法拦截
        emoticonButton.userInteractionEnabled = false
        
        addSubview(emoticonButton)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
