//
//  MetalView.m
//  HelloMetal
//
//  Created by osborn on 2018/9/21.
//  Copyright © 2018年 osborn. All rights reserved.
//

#import "MetalView.h"
#import <Metal/Metal.h>

@implementation MetalView

//metal render to layer like CAEAGLLayer
+ (id)layerClass {
    return [CAMetalLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _metalLayer = (CAMetalLayer *)[self layer];
        _device = MTLCreateSystemDefaultDevice();
        _metalLayer.device = _device;
        _metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    }
    return self;
}

- (void)didMoveToWindow {
    [self renderClear];
}


#pragma mark -- render

- (void)renderClear {
    
    id<CAMetalDrawable> drawable = [self.metalLayer nextDrawable];
    
    id<MTLTexture> texture = drawable.texture;
    
    MTLRenderPassDescriptor *passDescriptor = [MTLRenderPassDescriptor renderPassDescriptor];
    passDescriptor.colorAttachments[0].texture = texture;
    passDescriptor.colorAttachments[0].loadAction  = MTLLoadActionClear;
    passDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;
    passDescriptor.colorAttachments[0].clearColor  = MTLClearColorMake(0.0, 1.0, 1.0, 1.0);
    
    
    id<MTLCommandQueue> commandQueue   = [self.device newCommandQueue];
    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    id <MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:passDescriptor];
    [commandEncoder endEncoding];
    
    
    [commandBuffer presentDrawable:drawable];
    [commandBuffer commit];
    
}


@end
