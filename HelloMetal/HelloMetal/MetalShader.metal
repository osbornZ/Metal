//
//  MetalShader.metal
//  HelloMetal
//
//  Created by osborn on 2018/9/21.
//  Copyright © 2018年 osborn. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct ColoredVertex {
    float4 position [[position]];
    float4 color;
};

//顶点着色器
vertex ColoredVertex vertex_my(constant float4 *position [[buffer(0)]],
                                 constant float4 *color [[buffer(1)]],
                                 uint vid [[vertex_id]])
{
    ColoredVertex vert;
    vert.position = position[vid];
    vert.color    = color[vid];
    return vert;
}

//片元着色器
fragment float4 fragment_my(ColoredVertex vert [[stage_in]])
{
    return vert.color;
}
