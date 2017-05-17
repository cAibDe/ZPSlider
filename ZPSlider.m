//
//  ZPSlider.m
//  ZPSlider
//
//  Created by 张鹏 on 2017/5/10.
//  Copyright © 2017年 张鹏. All rights reserved.
//


#define ZPSlideWidth      (self.bounds.size.width)
#define ZPSliderHight     (self.bounds.size.height)

#define ZPSliderTitle_H   (ZPSliderHight*.3)

#define CenterImage_W     26.0

#define ZPSliderLine_W    (ZPSlideWidth-CenterImage_W)
#define ZPSLiderLine_H    6.0
#define ZPSliderLine_Y    (ZPSliderHight-ZPSliderTitle_H)


#define CenterImage_Y     (ZPSliderLine_Y+(ZPSLiderLine_H/2))

#import "ZPSlider.h"
@interface ZPSlider()
//计算起始滑块的中心x的位置
@property (nonatomic, assign) CGFloat firstPontX;
//计算终端滑块的中心x的位置
@property (nonatomic, assign) CGFloat lastPontX;
//起始滑块所在的位置
@property (nonatomic, assign) NSInteger firstSelectedInedx;
//终端滑块所在的位置
@property (nonatomic, assign) NSInteger lastSelectedInedx;
//计算两个title之间的宽度
@property (nonatomic, assign) CGFloat sectionWidth;
//title数组
@property (nonatomic, strong) NSArray *dataArray;
//滑块图片
@property (nonatomic, strong) UIImage *sliderImage;
//起始滑块所划过的视图
@property (nonatomic, strong) UIView *firstSelectView;
//终端滑块所划过的视图
@property (nonatomic, strong) UIView *lastSelectView;
//slider的背景图
@property (nonatomic, strong) UIView *defaultSliderView;
//起始滑块ImageView
@property (nonatomic, strong) UIImageView *firstCenterImage;
//终端滑块ImageView
@property (nonatomic, strong) UIImageView *lastCenterImage;
//起始滑块滑动的x距离
@property (nonatomic, assign) CGFloat firstXFromCenter;
//终端滑块滑动的x距离
@property (nonatomic, assign) CGFloat lastXFromCenter;
@end
@implementation ZPSlider
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
                 sliderTitles:(NSArray *)titleArray
            defaultFirstIndex:(CGFloat)defaultFirstIndex
             defaultLastIndex:(CGFloat)defaultLastIndex
                  sliderImage:(UIImage *)sliderImage{
    self = [super initWithFrame:frame];
    if (self) {
        //一些属性的赋值
        self.sectionWidth = ZPSliderLine_W/(titleArray.count-1);
        self.dataArray = titleArray;
        self.firstSelectedInedx = defaultFirstIndex;
        self.lastSelectedInedx = defaultLastIndex;
        self.firstPontX = CenterImage_W/2 + self.firstSelectedInedx*self.sectionWidth;
        self.lastPontX = ZPSliderLine_W - (self.dataArray.count-1-self.lastSelectedInedx)*self.sectionWidth;
        
        self.defaultSliderView = [[UIView alloc]initWithFrame:CGRectMake(CenterImage_W/2, (CenterImage_W-ZPSLiderLine_H)/2, ZPSliderLine_W, ZPSLiderLine_H)];
        self.defaultSliderView.backgroundColor = [UIColor grayColor];
        self.defaultSliderView.layer.cornerRadius = ZPSLiderLine_H/2;
        self.defaultSliderView.userInteractionEnabled = NO;
        [self addSubview:self.defaultSliderView];
        
        self.firstSelectView = [[UIView alloc]initWithFrame:CGRectMake(CenterImage_W/2, (CenterImage_W-ZPSLiderLine_H)/2, self.firstSelectedInedx*self.sectionWidth, ZPSLiderLine_H)];
        self.firstSelectView.backgroundColor = [UIColor greenColor];
        self.firstSelectView.layer.cornerRadius = ZPSLiderLine_H/2;
        self.firstSelectView.userInteractionEnabled = NO;
        [self addSubview:self.firstSelectView];
        
        self.lastSelectView = [[UIView alloc]initWithFrame:CGRectMake((ZPSliderLine_W+CenterImage_W/2)-(self.dataArray.count-1 - self.lastSelectedInedx)*self.sectionWidth, (CenterImage_W-ZPSLiderLine_H)/2, (self.dataArray.count-1 - self.lastSelectedInedx)*self.sectionWidth, ZPSLiderLine_H)];
        self.lastSelectView.backgroundColor = [UIColor yellowColor];
        self.lastSelectView.layer.cornerRadius = ZPSLiderLine_H/2;
        self.lastSelectView.userInteractionEnabled = NO;
        [self addSubview:self.lastSelectView];
        
        self.firstCenterImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.firstSelectedInedx*self.sectionWidth, 0, CenterImage_W, CenterImage_W)];
        self.firstCenterImage.image = sliderImage;
        self.firstCenterImage.userInteractionEnabled = YES;
        [self addSubview:self.firstCenterImage];
        
        UIPanGestureRecognizer *panFirstCenterImage = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panFirstCenterImage:)];
        [self.firstCenterImage addGestureRecognizer:panFirstCenterImage];
        
        self.lastCenterImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.lastSelectedInedx*self.sectionWidth, 0, CenterImage_W, CenterImage_W)];
        self.lastCenterImage.image = sliderImage;
        self.lastCenterImage.userInteractionEnabled = YES;
        [self addSubview:self.lastCenterImage];
        UIPanGestureRecognizer *panLastCenterImage = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panLastCenterImage:)];
        [self.lastCenterImage addGestureRecognizer:panLastCenterImage];
        
        for (int i = 0; i<self.dataArray.count; i++) {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CenterImage_W/2+i*self.sectionWidth, CenterImage_W+ZPSLiderLine_H, self.sectionWidth, 20)];
            titleLabel.text = [self.dataArray objectAtIndex:i];
            titleLabel.textColor = [UIColor blueColor];
            titleLabel.center = CGPointMake(CenterImage_W/2+i*self.sectionWidth, CenterImage_W+ZPSLiderLine_H*2);
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:titleLabel];
        }
    }
    return self;
}

- (void)panFirstCenterImage:(UIPanGestureRecognizer *)pan{
    self.firstXFromCenter = [pan translationInView:self.firstCenterImage].x;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.firstCenterImage.center = CGPointMake(self.firstPontX, CenterImage_W/2);
            break;
        case UIGestureRecognizerStateChanged:{
            if (self.firstPontX+self.firstXFromCenter <= CenterImage_W/2) {
                break;
            }
            if (self.firstPontX+self.firstXFromCenter >= self.lastCenterImage.center.x) {
                break;
            }
            self.firstCenterImage.center = CGPointMake(self.firstPontX+self.firstXFromCenter, CenterImage_W/2);
            self.firstSelectView.frame = CGRectMake(CenterImage_W/2, (CenterImage_W-ZPSLiderLine_H)/2,self.firstPontX+self.firstXFromCenter-CenterImage_W/2, ZPSLiderLine_H);
        }
            break;
        case UIGestureRecognizerStateEnded:{
            self.firstPontX = self.firstPontX + self.firstXFromCenter;
            [self changeFirstCenterImageX:self.firstPontX];
            NSLog(@"%f",self.firstPontX);
            self.firstCenterImage.center = CGPointMake(CenterImage_W/2+self.firstSelectedInedx*self.sectionWidth, CenterImage_W/2);
            self.firstSelectView.frame = CGRectMake(CenterImage_W/2, (CenterImage_W-ZPSLiderLine_H)/2, self.firstSelectedInedx*self.sectionWidth, ZPSLiderLine_H);
            if (self.block) {
                self.block((int)self.firstSelectedInedx,(int)self.lastSelectedInedx);
            }
        }
            break;
        default:
            break;
    }
}
- (void)changeFirstCenterImageX:(CGFloat)pointx{
    if (pointx<=0) {
        self.firstPontX = CenterImage_W/2;
    }else if(pointx>=self.lastPontX){
        self.firstPontX=(self.lastSelectedInedx -1)*self.sectionWidth+  CenterImage_W/2;
    }
    self.firstSelectedInedx = (int)roundf(self.firstPontX/self.sectionWidth);
    if (self.firstSelectedInedx== self.lastSelectedInedx && (self.lastSelectedInedx>0 && self.lastSelectedInedx<self.dataArray.count-1)) {
        self.firstSelectedInedx = self.firstSelectedInedx - 1;
    }
//    NSLog(@"self.firstSelectedInedx = %ld",(long)self.firstSelectedInedx);
}
- (void)panLastCenterImage:(UIPanGestureRecognizer *)pan{
    self.lastXFromCenter = [pan translationInView:self.lastCenterImage].x;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            self.lastCenterImage.center = CGPointMake(self.lastPontX, CenterImage_W/2);
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if (self.lastPontX + self.lastXFromCenter >= ZPSliderLine_W) {
                break;
            }
            if (self.lastPontX + self.lastXFromCenter <= self.firstCenterImage.center.x) {
                break;
            }
            self.lastCenterImage.center = CGPointMake(self.lastPontX+self.lastXFromCenter, CenterImage_W/2);
            self.lastSelectView.frame = CGRectMake((self.lastPontX + self.lastXFromCenter) , (CenterImage_W-ZPSLiderLine_H)/2, ZPSliderLine_W+CenterImage_W/2 - (self.lastPontX + self.lastXFromCenter), ZPSLiderLine_H);
        }
            break;
        case UIGestureRecognizerStateEnded:{
            self.lastPontX = self.lastPontX + self.lastXFromCenter;
            [self changeLastCenterImageX:self.lastPontX];
            
            self.lastCenterImage.center = CGPointMake(CenterImage_W/2+self.lastSelectedInedx*self.sectionWidth, CenterImage_W/2);
            self.lastSelectView.frame = CGRectMake((ZPSliderLine_W+CenterImage_W/2)-(self.dataArray.count-1 - self.lastSelectedInedx)*self.sectionWidth, (CenterImage_W-ZPSLiderLine_H)/2, (self.dataArray.count-1 - self.lastSelectedInedx)*self.sectionWidth, ZPSLiderLine_H);
            if (self.block) {
                self.block((int)self.firstSelectedInedx,(int)self.lastSelectedInedx);
            }
        }
            break;
        default:
            break;
    }
}
- (void)changeLastCenterImageX:(CGFloat)pointx{
    if (pointx<=self.firstPontX) {
        
        self.lastPontX = (self.firstSelectedInedx +1)*self.sectionWidth +CenterImage_W/2;
        
    }else if(pointx>=ZPSliderLine_W){
        self.lastPontX=ZPSliderLine_W+CenterImage_W/2;
    }
    self.lastSelectedInedx = (int)roundf(self.lastPontX/self.sectionWidth);
    if (self.firstSelectedInedx== self.lastSelectedInedx && (self.lastSelectedInedx>0 && self.lastSelectedInedx<self.dataArray.count-1)) {
        self.lastSelectedInedx = self.lastSelectedInedx + 1;
    }
//    NSLog(@"self.lastSelectedInedx = %ld",(long)self.lastSelectedInedx);
}
@end
