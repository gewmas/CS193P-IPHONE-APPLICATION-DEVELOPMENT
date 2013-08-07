//
//  fireAnimationViewController.m
//  fireAnimation
//
//  Created by Yuhua Mai on 8/7/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "fireAnimationViewController.h"

@interface fireAnimationViewController ()

@end

@implementation fireAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // create the view that will execute our animation
    UIImageView* campFireView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    // load all the frames of our animation
    campFireView.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"campFire01.gif"],
                                    [UIImage imageNamed:@"campFire02.gif"],
                                    [UIImage imageNamed:@"campFire03.gif"],
                                    [UIImage imageNamed:@"campFire04.gif"],
                                    [UIImage imageNamed:@"campFire05.gif"],
                                    [UIImage imageNamed:@"campFire06.gif"],
                                    [UIImage imageNamed:@"campFire07.gif"],
                                    [UIImage imageNamed:@"campFire08.gif"],
                                    [UIImage imageNamed:@"campFire09.gif"],
                                    [UIImage imageNamed:@"campFire10.gif"],
                                    [UIImage imageNamed:@"campFire11.gif"],
                                    [UIImage imageNamed:@"campFire12.gif"],
                                    [UIImage imageNamed:@"campFire13.gif"],
                                    [UIImage imageNamed:@"campFire14.gif"],
                                    [UIImage imageNamed:@"campFire15.gif"],
                                    [UIImage imageNamed:@"campFire16.gif"],
                                    [UIImage imageNamed:@"campFire17.gif"], nil];
    
    // all frames will execute in 1.75 seconds
    campFireView.animationDuration = 0.75;
    // repeat the annimation forever
    campFireView.animationRepeatCount = 0;
    // start animating
    [campFireView startAnimating];
    // add the animation view to the main window
    [self.view addSubview:campFireView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
