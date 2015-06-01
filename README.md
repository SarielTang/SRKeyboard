## SRKeyboard

* 最简单的实现自定义表情键盘,以及进行图文混排的,并能以文本形式上传服务器的框架
* The simplest implementation of the custom expression keyboard, as well as the RichText, and can upload the framework of the server in text form

## Requirements

* iOS 6.0+ 
* Xcode 6.1.1

## Installation

* 手动导入：
    * 将`SRKeyboard/Classes`文件夹中的所有文件拽入项目中
    * 导入主头文件：`#import <SRKeyboard/SRKeyboard.h>`
    * 

## Usage
### Custom Emoticon Keyboard and TextView with RichText
### 自定义表情键盘和含图文混排的TextView
```
#import <SRKeyboard/SRKeyboard.h>

@property (weak, nonatomic) IBOutlet EmoticonsTextView *textView;
@property (strong,nonatomic) SRKeyboardController *emoticonKeyboardVC;

- (SRKeyboardController *)emoticonKeyboardVC {
    if (_emoticonKeyboardVC == nil) {
        __weak ViewController *weakSelf = self;
        _emoticonKeyboardVC = [[SRKeyboardController alloc]initWithEmoticonBlock:^(Emoticons *emoticons) {
            [weakSelf.textView insertEmoticon:emoticons];
        }];
    }
    return _emoticonKeyboardVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self addChildViewController:self.emoticonKeyboardVC];
    //设置textView的输入视图
    self.textView.inputView = self.emoticonKeyboardVC.view;
}

```
* and add the textView in your project.
* Then, you can have a customEmoticonKeyboard.
* 然后,将这个textView添加到项目中.
* 你就可以拥有一个能够支持图文混排的textView和自定义的表情键盘了.
* 另外,如果你想要自己添加其他的表情组进去的话,
* 你可以按照Emoticons.boundle中的其他已经存在的表情文件夹中的info.plist中的格式,添加相应的plist文件.
* 然后再在emoticons.plist中,添加这个表情组的相应内容,即可.
##Screenshot
![image](https://github.com/SarielTang/SRKeyboard/blob/master/ScreenShot/SRKeyboardIntroduce1.gif)
