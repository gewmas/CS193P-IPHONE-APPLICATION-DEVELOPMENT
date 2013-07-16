//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Yuhua Mai on 7/2/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index chooseMode:(NSUInteger)mode;

- (Card *)cardAtIndex:(NSUInteger)index;

- (NSString*)updateResultOfLastFlip;

- (void)restartGame;

- (void)changeGameStatus:(NSUInteger)round;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) int roundsPlayed;

@end
