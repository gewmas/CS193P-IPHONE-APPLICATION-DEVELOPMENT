//
//  PlayingSetDeck.m
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "PlayingSetDeck.h"
#import "PlayingSet.h"

@implementation PlayingSetDeck

- (id) init
{
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [PlayingSet validSymbol]){
            for (NSString *shading in [PlayingSet validShading]){
                for (NSString *color in [PlayingSet validColor]) {
                    for (NSUInteger number = 1; number <= [PlayingSet maxNumber]; number++){
                        PlayingSet *set = [[PlayingSet alloc] init];
                        set.symbol = symbol;
                        set.shading = shading;
                        set.color = color;
                        set.number = number;
                        [self addCard:set atTop:YES];
//                        NSLog(@"%@ %@ %@ %d %@", set.symbol, set.shading, set.color, set.number, set.attribtedContents);
                    }
                }
            }
        }
    }
    
    return self;
}

@end
