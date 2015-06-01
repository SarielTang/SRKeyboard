//
//  ViewController.m
//  SRKeyboardDemo
//
//  Created by Sariel's Mac on 15-5-24.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import "ViewController.h"
#import <SRKeyboard/SRKeyboard.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet EmoticonsTextView *textView;

@property (strong,nonatomic) SRKeyboardController *emoticonKeyboardVC;

@end

@implementation ViewController

- (SRKeyboardController *)emoticonKeyboardVC {
    if (_emoticonKeyboardVC == nil) {
        __weak ViewController *weakSelf = self;
        _emoticonKeyboardVC = [[SRKeyboardController alloc]initWithEmoticonBlock:^(Emoticons *emoticons) {
            [weakSelf.textView insertEmoticon:emoticons];
        }];
    }
    return _emoticonKeyboardVC;
}

-(void)dealloc{
    NSLog(@"----88-----");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self addChildViewController:self.emoticonKeyboardVC];
    //设置textView的输入视图
    self.textView.inputView = self.emoticonKeyboardVC.view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
