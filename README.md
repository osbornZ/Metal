# Metal


凡事 What. Why. How。

__Metal__ 是一个和OpenGL ES 类似的面向底层/低开销的硬件加速图形编程接口，通过使用相关的 API 可以直接操作GPU.

* 2014年的 WWDC 的时候发布 1.0
* 2017发布了 Metal 2.0
* 2019发布了 Metal 3.0

虽然没有 openGL ES 的跨平台能力，但是有 Apple 独有的系统加成，更大的挖掘GPU的能力。Apple 从iOS 12 开始将逐步废弃 openGL openCL。

图像界面展示的渲染流程:

	UIKit -> Core Graphics -> Metal/OpenGL ES -> GPU Driver -> GPU



### start

既然和 openGL ES有同样的功效，步骤流程也相似。最后会回到shader编写上，[MSL](Metal-Shading-Language-Specification.pdf) 采用C++的结构方式。

| / | openGL ES | Metal |备注| 
|--- |--- | ---|---|
|语言 |GLSL | MSL |
|--- |--- | ---|






### Metal 与 CoreImage

......



[Metal wikipedia](https://zh.wikipedia.org/wiki/Metal_(API))


