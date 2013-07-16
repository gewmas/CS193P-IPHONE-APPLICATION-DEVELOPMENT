//
//  PlayingSet.m
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "PlayingSet.h"

@implementation PlayingSet

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    return score;
}

- (NSString *)contents
{
    return @"test";
}

//@synthesize attribtedContents = _attribtedContents;
- (NSAttributedString *)attribtedContents
{
    NSDictionary *attributes = @{
                NSForegroundColorAttributeName: [UIColor purpleColor],
                NSBackgroundColorAttributeName: [UIColor yellowColor],
                NSUnderlineStyleAttributeName: @1
                                 };
    
    NSAttributedString *myString = [[NSAttributedString alloc] initWithString:@"Testing Attributed Strings" attributes:attributes];
    
    return myString;
}

+ (NSArray *)validSymbol
{
    static NSArray *validSymbol = nil;
    if (!validSymbol) validSymbol = @[@"▲", @"●", @"■"];
    return validSymbol;
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[PlayingSet validSymbol] containsObject:symbol]) {
        _symbol = symbol;
    }
}

+ (NSArray *)validShading
{
    static NSArray *validShading = nil;
    if (!validShading) validShading = @[@"solid", @"striped", @"open"];
    return validShading;
}

- (void)setShading:(NSString *)shading
{
    if ([[PlayingSet validShading] containsObject:shading]) {
        _shading = shading;
    }
}

+ (NSArray *)validColor
{
    static NSArray *validColor = nil;
    if (!validColor) validColor = @[@"red", @"green", @"purple"];
    return validColor;
}

- (void)setColor:(NSString *)color
{
    if ([[PlayingSet validColor] containsObject:color]) {
        _color = color;
    }
}

+ (NSUInteger)maxNumber
{
    return 3;
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [PlayingSet maxNumber]) {
        _number = number;
    }
}

@end
