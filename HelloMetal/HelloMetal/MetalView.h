//
//  MetalView.h
//  HelloMetal
//
//  Created by osborn on 2018/9/21.
//  Copyright © 2018年 osborn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetalView : UIView

@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, weak) CAMetalLayer *metalLayer;


@end
