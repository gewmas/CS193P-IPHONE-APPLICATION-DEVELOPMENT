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
    
    if (otherCards.count == 2) {
        PlayingSet *set2 = otherCards[0];
        PlayingSet *set3 = otherCards[1];
        //NSLog(@"%d %@",otherCard.rank, otherCard.suit);
        
        BOOL checkNumber = (self.number == set2.number && self.number == set3.number) || (self.number != set2.number && self.number != set3.number && set2.number != set3.number);
        
        BOOL checkSymbolPair1 = [self.symbol isEqualToString:set2.symbol];
        BOOL checkSymbolPair2 = [self.symbol isEqualToString:set3.symbol];
        BOOL checkSymbolPair3 = [set2.symbol isEqualToString:set3.symbol];
        BOOL checkSymbol = (checkSymbolPair1 && checkSymbolPair2 && checkSymbolPair3) || (!checkSymbolPair1 && !checkSymbolPair2 && !checkSymbolPair3);
        
        BOOL checkColorPair1 = [self.color isEqual:set2.color];
        BOOL checkColorPair2 = [self.color isEqual:set3.color];
        BOOL checkColorPair3 = [set2.color isEqual:set3.color];
        
        BOOL checkColor = (checkColorPair1 && checkColorPair2 && checkColorPair3) || (!checkColorPair1 && !checkColorPair2 && !checkColorPair3);
        
        NSLog(@"number: %d symbol: %d color: %d", checkNumber, checkSymbol, checkColor);
        
        if (checkNumber && checkSymbol && checkColor) {
            score = 10;
        }
    }
    
    return score;
}

- (NSString *)contents
{
    return @"test";
}

//@synthesize attribtedContents = _attribtedContents;
- (NSMutableAttributedString *)attribtedContents
{

    NSDictionary *attributes = @{
                                  NSForegroundColorAttributeName: self.color
                                 //NSBackgroundColorAttributeName: [UIColor yellowColor],
                                 //NSUnderlineStyleAttributeName: @1
                                 };

    
    
    NSMutableAttributedString *myString1 = [[NSMutableAttributedString alloc] initWithString:self.symbol attributes:attributes];

    NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithString:self.symbol attributes:attributes];
    
    if (self.number == 2){
        [myString appendAttributedString:myString1];
    } else if(self.number == 3){
        [myString appendAttributedString:myString1];
        [myString appendAttributedString:myString1];
    }
    
    return myString;
}

+ (NSArray *)validSymbol
{
    static NSArray *validSymbol = nil;
    if (!validSymbol) validSymbol = @[@"▲", @"△", @"▵", @"●", @"○", @"◎", @"■", @"□", @"☒"];
    return validSymbol;
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[PlayingSet validSymbol] containsObject:symbol]) {
        _symbol = symbol;
    }
}

//+ (NSArray *)validShading
//{
//    static NSArray *validShading = nil;
//    if (!validShading) validShading = @[@"solid", @"striped", @"open"];
//    return validShading;
//}
//
//- (void)setShading:(NSString *)shading
//{
//    if ([[PlayingSet validShading] containsObject:shading]) {
//        _shading = shading;
//    }
//}

+ (NSMutableArray *)validColor
{
    static NSMutableArray *validColor = nil;
    if (!validColor){
        validColor = [[NSMutableArray alloc] init];
        [validColor insertObject:[UIColor redColor] atIndex:0];
        [validColor insertObject:[UIColor greenColor] atIndex:1];
        [validColor insertObject:[UIColor purpleColor] atIndex:2];
    }
    return validColor;
}

- (void)setColor:(UIColor *)color
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
