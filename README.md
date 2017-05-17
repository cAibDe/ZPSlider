# ZPSlider
一个双向滑块的Slider
# 前提
这个是在一次和朋友吃饭的时候，我们唠嗑的时候他说的一个需求。因为系统的Slider是只有一个滑块的，而且没有分段滑动的效果。
这不最近都在研究这么个需求。

# How to use it 
```objc
-(instancetype)initWithFrame:(CGRect)frame
                sliderTitles:(NSArray *)titleArray
           defaultFirstIndex:(CGFloat)defaultFirstIndex
            defaultLastIndex:(CGFloat)defaultLastIndex
                 sliderImage:(UIImage *)sliderImage;

```
这就是一个极其普通的初始化函数，只要传入你的slider两边滑块的初始位置，和你滑块的图片就可以了。

※友情提示，你传的位置一定要在你的数组范围之内。

这里还有个block用于传出最终选择的参数
```objc
typedef void(^sliderValueChange)(int firstIndexPath , int lastIndexPath);
```
我这个Demo只是传出了index，各位可以根据需要修改传出的参数。

# 效果
![ZPSlider.gif](http://upload-images.jianshu.io/upload_images/2368708-3495bdbb243474a4.gif?imageMogr2/auto-orient/strip)
# 吐槽区
欢迎各位使用过后对我尽情的吐槽
