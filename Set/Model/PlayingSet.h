//
//  PlayingSet.h
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "Card.h"

@interface PlayingSet : Card

//@property (strong, nonatomic) NSAttributedString *attribtedContents;

@property (strong, nonatomic) NSString *symbol;
//@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) UIColor *color;

@property (nonatomic) NSUInteger number;

+ (NSArray *)validSymbol;
//+ (NSArray *)validShading;
+ (NSMutableArray *)validColor;
+ (NSUInteger)maxNumber;

@end
