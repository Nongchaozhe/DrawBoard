//
//  ViewController.m
//  DrawBoard
//
//  Created by 弄潮者 on 15/8/7.
//  Copyright (c) 2015年 弄潮者. All rights reserved.
//

#import "ViewController.h"
#import "ToolView.h"
#import "DrawView.h"

//iOS 画板的实现，具有颜色、线宽、橡皮、撤销和清屏功能
//————
//完成一个简单地画板，能够实现画壁颜色和线宽的选择，以及橡皮功能，撤销前一步的操作，和清屏功能
//主要应用MVC模式进行代码架构，每一部分的代码实现思路在各部分的代码前面。
//————
//效果图如下：
//————

/**
 *  控制器实现基本思路：1、添加工具栏和画板
                     2、ToolView中block的定义，colorBlock，widthBlock就是设置drawView的color；eraseBlock就设置其lineWidth和lineColor的具体值；undoBlock，clearBlock调用DrawView的函数
 */
#define Zwidth [UIScreen mainScreen].bounds.size.width
#define Zheight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    工具栏的实现
    ToolView *topView = [[ToolView alloc] initWithFrame:CGRectMake(0, 20, Zwidth, 130)];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topView];
    
//    画板的实现
    DrawView *drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 150, 375, Zheight-170)];
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
    
//    BLOCK的实现
    topView.colorBlock = ^(UIColor *color){
        drawView.lineColor = color;
    };
    
     topView.widthBlock = ^(CGFloat width){
        drawView.lineWidth = width;
    };
    
    topView.eraserBlock = ^(void){
        drawView.lineWidth = 20;
        drawView.lineColor = [UIColor whiteColor];
    };
    
    topView.undoBlock = ^{
        [drawView undoAction];
    };
    
    topView.clearBlock = ^{
        [drawView clearAction];
        
    };

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
