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
    
    if (self)
    {
        for (NSString *symbol in [PlayingSet validSymbol])
        {
           for (int colorIndex = 0; colorIndex < 3; colorIndex++)
           {
        
                for (NSUInteger number = 1; number <= [PlayingSet maxNumber]; number++)
                {
                    PlayingSet *set = [[PlayingSet alloc] init];
                    
                    set.number = number;
                    set.symbol = symbol;
                    set.color = [PlayingSet validColor][colorIndex];
                
                                                            
                    [self addCard:set atTop:YES];
                }
            }
        }
    }
     
    
    return self;
}

@end
