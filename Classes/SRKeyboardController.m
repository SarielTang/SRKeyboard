//
//  SRKeyboard.m
//  自定义表情键盘
//
//  Created by xl_bin on 15/5/28.
//  Copyright (c) 2015年 Sariel. All rights reserved.
//

#import "SRKeyboardController.h"
#import "Emoticons.h"
#import "EmoticonsGroup.h"
#import "SRKeyboardCell.h"

///SRKeyboard类
@interface SRKeyboardController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *emoticonsList;

@property (nonatomic, copy) void (^selectedEmoticon)(Emoticons *emoticons);

@end

@implementation SRKeyboardController

- (instancetype)initWithEmoticonBlock:(void (^)(Emoticons *))selectedEmoticon {
    if ((self = [super initWithNibName:nil bundle:nil])){
        //记录闭包
        self.selectedEmoticon = selectedEmoticon;
    }
    return self;
}

///自定义toolBar
- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        
        NSArray *array = [EmoticonsGroup emoticonsGroups];
        //添加items
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:array.count];
        __block int pageIndex = 0;
        [array enumerateObjectsUsingBlock:^(EmoticonsGroup *group, NSUInteger idx, BOOL *stop) {
            NSString *str = group.emoticon_group_name;
            UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStyleDone target:self action:@selector(selectItem:)];
            [items addObject:bar];
            //根据每组的表情数目进行toolBar的布局
            bar.tag = pageIndex;
            pageIndex += ([group groupEmoticonsList].count / 21);
            
            if (idx < array.count-1) {
                [items addObject:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
            }
        }];
        _toolBar.items = items;
        _toolBar.tintColor = [UIColor darkGrayColor];
    }
    return _toolBar;
}
///自定义collectionView
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width / 7;
        layout.itemSize = CGSizeMake(w, w);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(4, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = true;
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        // 注册原型cell
        [_collectionView registerClass:[SRKeyboardCell class] forCellWithReuseIdentifier:SRKeyboardCellID];
    }
    return _collectionView;
}
///选择对应的表情组
- (void)selectItem:(UIBarButtonItem *)bar {
//    NSLog(@"%ld",(long)bar.tag);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:bar.tag * 21 inSection:0];
    //滚动到对应的indexPath
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
///加载View
- (void)loadView{
    [super loadView];
    [self setupUI];
}
///布局
- (void)setupUI {
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.collectionView];
    
    //设置自动布局
    [self.toolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSMutableArray *cons = [NSMutableArray array];
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|" options:0 metrics:nil views:@{@"collectionView" : self.collectionView}]];
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolBar]-0-|" options:0 metrics:nil views:@{@"toolBar": self.toolBar}]];
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[collectionView]-[toolBar(44)]-0-|" options:0 metrics:nil views:@{@"toolBar": self.toolBar, @"collectionView": self.collectionView}]];
    [self.view addConstraints:cons];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - UICollectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexPath取得用户选中的表情
    SRKeyboardCell *cell = (SRKeyboardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        //回调闭包
        self.selectedEmoticon(cell.emoticons);
    }
}

#pragma mark - UICollectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.emoticonsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SRKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SRKeyboardCellID forIndexPath:indexPath];
    
    cell.emoticons = self.emoticonsList[indexPath.item];
    
    return cell;
}

///加载表情数组
- (NSArray *)emoticonsList{
    if (_emoticonsList == nil) {
        _emoticonsList = [Emoticons emoticonsList];
    }
    return _emoticonsList;
}
@end

