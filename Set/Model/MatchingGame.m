//
//  MatchingGame.m
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "MatchingGame.h"

@interface MatchingGame()
@end

@implementation MatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                //NSLog(@"%d %@ %@",card.isFaceUp, card.contents, card.attribtedContents);
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    //NSLog(@"index %d", index);
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
