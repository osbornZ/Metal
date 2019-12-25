//
//  ViewController.m
//  HelloMetal
//
//  Created by osborn on 2018/9/21.
//  Copyright © 2018年 osborn. All rights reserved.
//

#import "ViewController.h"
#import "MetalView.h"

#define  kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define  kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@property (nonatomic,strong) MetalView *metalV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUIControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initUIControl {
    self.metalV = [[MetalView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.metalV];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat safeAreaTop    = 0;
    CGFloat safeAreaBootom = 0;
    if (@available(iOS 11.0, *)) {
        safeAreaTop += self.view.safeAreaInsets.top;
        safeAreaBootom += self.view.safeAreaInsets.bottom;
    }
    self.metalV.frame = CGRectMake(0, safeAreaTop, kScreenWidth, kScreenHeight-safeAreaBootom);
    
}


@end
