//
//  MetalView.m
//  HelloMetal
//
//  Created by osborn on 2018/9/21.
//  Copyright © 2018年 osborn. All rights reserved.
//

#import "MetalView.h"
#import <Metal/Metal.h>
#import "MetalContext.h"

@interface MetalView()

@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id<MTLCommandQueue> commandQueue;

@property (nonatomic, weak) CAMetalLayer *metalLayer;

@property (nonatomic, strong) MetalContext *metalContext;
@property (nonatomic, strong) id<MTLBuffer> positionBuffer;
@property (nonatomic, strong) id<MTLBuffer> colorBuffer;

@property (nonatomic, strong) id<MTLRenderPipelineState> pipeline;

//NSTimer  xxx 60 FPS
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation MetalView

//metal render to layer like CAEAGLLayer
+ (id)layerClass {
    return [CAMetalLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpContext];
        [self setUpVertexBuffers];
        [self setUpPipeline];
    }
    return self;
}

- (void)setUpContext {
    self.metalContext = [MetalContext defaultContext];
    
    _device = _metalContext.device;
    _metalLayer = (CAMetalLayer *)[self layer];
    _metalLayer.device  = _device;
    _metalLayer.pixelFormat   = MTLPixelFormatBGRA8Unorm;
    _metalLayer.contentsScale = [UIScreen mainScreen].scale;
}


- (void)setUpVertexBuffers {
    
    static const float positions[] = {
        0.0,  0.5, 0, 1,
        -0.5, -0.5, 0, 1,
        0.5, -0.5, 0, 1,
    };
    
    static const float colors[] = {
        1, 0, 0, 1,
        0, 1, 0, 1,
        0, 0, 1, 1,
    };
    
    //gpu cpu 共享缓冲区块
    self.positionBuffer = [self.device newBufferWithBytes:positions
                                                   length:sizeof(positions)
                                                  options:MTLResourceOptionCPUCacheModeDefault];
    self.colorBuffer = [self.device newBufferWithBytes:colors
                                                length:sizeof(colors)
                                               options:MTLResourceOptionCPUCacheModeDefault];
}


- (void)setUpPipeline {
    id<MTLLibrary> library = [self.device newDefaultLibrary];
    
//openGL  program 槽点
    id<MTLFunction> vertexFunc   = [library newFunctionWithName:@"vertex_my"];
    id<MTLFunction> fragmentFunc = [library newFunctionWithName:@"fragment_my"];
    
//   check state
    MTLRenderPipelineDescriptor *pipelineDescriptor = [MTLRenderPipelineDescriptor new];
    pipelineDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    pipelineDescriptor.vertexFunction   = vertexFunc;
    pipelineDescriptor.fragmentFunction = fragmentFunc;
    
    NSError *error = nil;
    self.pipeline = [self.device newRenderPipelineStateWithDescriptor:pipelineDescriptor
                                                                error:&error];

    if (!self.pipeline) {
        NSLog(@"Error occurred when creating render pipeline state: %@", error);
    }
    
    self.commandQueue = [self.device newCommandQueue];
}


- (void)didMoveToWindow {
    [self renderTriangle];

//  repeat redraw like GLKView render
//    [super didMoveToSuperview];
//    if (self.superview) {
//        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkDidFire:)];
//        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    }else {
//        [self.displayLink invalidate];
//        self.displayLink = nil;
//    }

}


//background stop
- (void)displayLinkDidFire:(CADisplayLink *)displayLink {
    [self renderTriangle];
}


#pragma mark -- render

- (void)renderTriangle {
    
//  CAMetalDrawable 协议是MTLDrawable 的扩展，指定了可显示资源对象要符合的MTLTexture协议
    id<CAMetalDrawable> drawable = [self.metalLayer nextDrawable];
    
    id<MTLTexture> texture = drawable.texture;
    
    
//  对象附着点要呈现的图形目标
    MTLRenderPassDescriptor *passDescriptor = [MTLRenderPassDescriptor renderPassDescriptor];
    passDescriptor.colorAttachments[0].texture = texture;
    passDescriptor.colorAttachments[0].loadAction  = MTLLoadActionClear;
    passDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;
    passDescriptor.colorAttachments[0].clearColor  = MTLClearColorMake(0.0, 1.0, 1.0, 1.0);
    
    
//    命令编码器对象
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    
    
    id <MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:passDescriptor];
    [commandEncoder setRenderPipelineState:self.pipeline];
    [commandEncoder setVertexBuffer:self.positionBuffer offset:0 atIndex:0 ];
    [commandEncoder setVertexBuffer:self.colorBuffer offset:0 atIndex:1 ];
    
//MTLPrimitiveTypeTriangle 独立三角形
    [commandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3 instanceCount:1];
    
    [commandEncoder endEncoding];

    [commandBuffer presentDrawable:drawable];

//  对象提交执行
    [commandBuffer commit];
    
}


//纹理绘制
- (void)renderTexture {
//    Encoder  命令编码器协议
//    MTLBlitCommandEncoder  提供接口用来编码在缓冲和纹理之间的简单拷贝操作
    
}





@end
