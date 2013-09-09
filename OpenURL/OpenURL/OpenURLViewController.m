//
//  OpenURLViewController.m
//  OpenURL
//
//  Created by Yuhua Mai on 8/14/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "OpenURLViewController.h"


@interface OpenURLViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end

@implementation OpenURLViewController

@synthesize addressTextField = _addressTextField;

-(IBAction)openMaps{
    //NSString* addressText = @"1 Queen st, Auckland, NZ";
    NSString *addressText = self.addressTextField.text;
    //NSLog(@"%@", self.addressTextField.text);
    
    addressText = [addressText stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    NSString* urlText = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",addressText];
    //NSlog(urlText);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.addressTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.addressTextField.delegate = self;//!!!!!
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
