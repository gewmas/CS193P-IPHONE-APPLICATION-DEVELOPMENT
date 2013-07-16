//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Yuhua Mai on 7/2/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "MatchingGame.h"
#import "Deck.h"

@interface CardMatchingGame : MatchingGame



- (void)flipCardAtIndex:(NSUInteger)index chooseMode:(NSUInteger)mode;

- (NSString*)updateResultOfLastFlip;

- (void)restartGame;

@property (nonatomic, readonly) int score;

@end
