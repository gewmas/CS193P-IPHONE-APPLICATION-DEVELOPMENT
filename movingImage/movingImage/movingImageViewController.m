//
//  movingImageViewController.m
//  movingImage
//
//  Created by Yuhua Mai on 8/14/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "movingImageViewController.h"

@interface movingImageViewController ()

@end

@implementation movingImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //定义图片的位置和尺寸,位置:x=10.0f, y=10.0f ,尺寸:x=50.0f, y=40.0f
    UIImageView *subview = [[UIImageView alloc] initWithFrame:
                            CGRectMake(10.0f, 10.0f, 50.0f, 40.0f)];
    
    //设定图片名称,myPic.png已经存在，拖放添加图片文件到image项目文件夹中
    [subview setImage:[UIImage imageNamed:@"myPic.png"]];
    
    //启用动画移动
    [UIImageView beginAnimations:nil context:NULL];
    
    //移动时间2秒
    [UIImageView setAnimationDuration:10];
    
    //图片持续移动
    [UIImageView setAnimationBeginsFromCurrentState:YES];
    
    //重新定义图片的位置和尺寸,位置
    subview.frame = CGRectMake(60.0, 100.0,200.0, 300.0);
    
    //完成动画移动
    [UIImageView commitAnimations];
    
    //在 View 中加入图片 subview
    [self.view addSubview:subview];
    
    //使用后释放图片, 使用iOS5,对像为iOS4.3以上可以忽略这步骤
    //[subview release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
