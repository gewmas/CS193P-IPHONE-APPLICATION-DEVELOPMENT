//
//  MatchingGame.h
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface MatchingGame : NSObject

@property (strong, nonatomic) NSMutableArray *cards;

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
- (Card *)cardAtIndex:(NSUInteger)index;


@end
