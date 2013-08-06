//
//  ViewController.h
//  minutesToMidnight
//
//  Created by Yuhua Mai on 8/6/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSTimer *timer;
    
    IBOutlet UILabel *countdownLabel;
}

@property(nonatomic,retain)  UILabel *countdownLabel;

@property (nonatomic, retain) NSTimer *timer;

-(void)onTimer;

@end
