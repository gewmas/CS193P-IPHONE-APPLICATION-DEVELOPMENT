//
//  Photo.h
//  Photomania
//
//  Created by Yuhua Mai on 8/5/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) Photographer *whoTook;

@end
