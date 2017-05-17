//
//  ViewController.m
//  ZPSlider
//
//  Created by 张鹏 on 2017/5/10.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import "ViewController.h"
#import "ZPSlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZPSlider *slider=[[ZPSlider alloc] initWithFrame:CGRectMake(50, 50, 300, 50) sliderTitles:@[@"10",@"20",@"30",@"40",@"50",@"60"] defaultFirstIndex:2 defaultLastIndex:4 sliderImage:[UIImage imageNamed:@"日历"]];
    [self.view addSubview:slider];
    
    slider.backgroundColor = [UIColor redColor];
//    slider.block=^(int index){
//        NSLog(@"当前index==%d",index);
//    };
    slider.block = ^(int firstIndexPath, int lastIndexPath) {
        NSLog(@"firstIndexPath = %d,lastIndexPath = %d",firstIndexPath,lastIndexPath);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
