//
//  ViewController.m
//  minutesToMidnight
//
//  Created by Yuhua Mai on 8/6/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize timer;

@synthesize countdownLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [countdownLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:36.0]];
    countdownLabel.text = @"00:00:00";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTimer{
    NSDate* now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSHourCalendarUnit  | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now]; //不换行
    NSInteger hour = [dateComponents hour];
    NSInteger min = [dateComponents minute];
    NSInteger sec = [dateComponents second];
    sec = 60 - sec;
    min = 59 - min;
    hour = 23 -  hour;
//    [gregorian release];
    
    countdownLabel.text = [NSString stringWithFormat:@"%d:%d:%d", hour, min,sec];
    
}

@end
