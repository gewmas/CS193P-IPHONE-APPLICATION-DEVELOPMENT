//
//  ViewController.m
//  fileSize
//
//  Practice According to http://blog.sina.com.cn/s/blog_5fae23350102dwgu.html
//
//  Createdby Yuhua Mai on 8/5/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *URLString = @"http://s1.sinaimg.cn/orignal/5fae2335gb88f014a0430&690";//@"http://ww3.sinaimg.cn/bmiddle/7ba513cajw1e7cec06gr3j20bx0gotcu.jpg";
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]]];
    
    NSLog(@"%f, %f", image.size.width, image.size.height);
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSLog(@"%@", docDir);
    
    NSLog(@"Saving jpg");
    NSString *jpgFilePath = [NSString stringWithFormat:@"%@/test.jpg", docDir];
    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];
    [data writeToFile:jpgFilePath atomically:YES];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    NSLog(@"Saving image done.");
    
    UIImageView *webImageView = [[UIImageView alloc] initWithImage:image];
    webImageView.frame = CGRectMake(5, 170, image.size.width, image.size.height);
    [self.view addSubview:webImageView];
    
    int count = [self cacheFolderSize];
    count = count / 1000;
    NSLog(@"Total image file size: %i", count);
    
    UILabel *sizeLabel = [[UILabel alloc] init];
    sizeLabel.font = [UIFont fontWithName:@"Helvetica" size:12.5];
    sizeLabel.frame = CGRectMake(0, 20, 320, 140);
    sizeLabel.numberOfLines = 7;
    sizeLabel.text = [NSString stringWithFormat:@"Link: %@. Size in the album: %i KB", URLString, count];
    [self.view addSubview:sizeLabel];

    UILabel *crLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    crLabel.backgroundColor = [UIColor clearColor];
    crLabel.textColor = [UIColor grayColor];
    crLabel.text = @"blog.sina.com.cn/iphonesdk";
    [self.view addSubview:crLabel];
}

//get size of folder
- (unsigned long long int)cacheFolderSize
{
    NSFileManager *_manager = [NSFileManager defaultManager];
    
    //NSArray *_cachePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *_cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *_cacheFileList;
    NSEnumerator *_cacheEnumerator;
    NSString *_cacheFilePath;
    
    NSError *error = nil;
    
    unsigned long long int _cacheFolderSize = 0;
    
    _cacheFileList = [_manager subpathsAtPath:_cacheDirectory];
    _cacheEnumerator = [_cacheFileList objectEnumerator];
    
    while (_cacheFilePath = [_cacheEnumerator nextObject]) {
        NSString *file = [_cacheDirectory stringByAppendingPathComponent:_cacheFilePath];
        
        if ([[file pathExtension] isEqualToString:@"jpg"]) {
            NSDictionary *_cacheFileAttributes = [_manager attributesOfItemAtPath:file error:&error];
            
            _cacheFolderSize += [_cacheFileAttributes fileSize];
        }
    }
    
    return _cacheFolderSize;
}

@end
