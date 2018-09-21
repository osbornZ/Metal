//
//  MetalContext.m
//  HelloMetal
//
//  Created by osborn on 2018/9/21.
//  Copyright © 2018年 osborn. All rights reserved.
//

#import "MetalContext.h"

@implementation MetalContext

+ (instancetype)defaultContext {
    static dispatch_once_t onceToken;
    static MetalContext *instance = nil;
    dispatch_once(&onceToken, ^{
        id<MTLDevice> device = MTLCreateSystemDefaultDevice();
        instance = [[MetalContext alloc] initWithDevice:device];
    });
    
    return instance;
}

- (instancetype)initWithDevice:(id<MTLDevice>)device {
    if ((self = [super init])) {
        _device = device;
        _library = [_device newDefaultLibrary];
        _commandQueue = [_device newCommandQueue];
    }
    
    return self;
}

@end
