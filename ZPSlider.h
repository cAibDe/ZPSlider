//
//  ZPSlider.h
//  ZPSlider
//
//  Created by 张鹏 on 2017/5/10.
//  Copyright © 2017年 张鹏. All rights reserved.
//


typedef void(^sliderValueChange)(int firstIndexPath , int lastIndexPath);

#import <UIKit/UIKit.h>

@interface ZPSlider : UIControl

@property (nonatomic, copy) sliderValueChange block;

-(instancetype)initWithFrame:(CGRect)frame
                sliderTitles:(NSArray *)titleArray
           defaultFirstIndex:(CGFloat)defaultFirstIndex
            defaultLastIndex:(CGFloat)defaultLastIndex
                 sliderImage:(UIImage *)sliderImage;



@end
