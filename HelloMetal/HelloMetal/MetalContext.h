//
//  MetalContext.h
//  HelloMetal
//
//  Created by osborn on 2018/9/21.
//  Copyright © 2018年 osborn. All rights reserved.
//
//
// config Device Library Context

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

@interface MetalContext : NSObject

@property (nonatomic, strong) id<MTLDevice> device;
@property (nonatomic, strong) id<MTLLibrary> library;
@property (nonatomic, strong) id<MTLCommandQueue> commandQueue;

+ (instancetype)defaultContext;
- (instancetype)initWithDevice:(id<MTLDevice>)device;


@end
