//
//  SetMatchingGame.h
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "MatchingGame.h"
#import "Deck.h"

@interface SetMatchingGame : MatchingGame

- (void)flipSetAtIndex:(NSUInteger)index;

- (void)restartGame;

@property (nonatomic, readonly) int score;

@property (strong, nonatomic) NSMutableAttributedString *resultOfLastFlip;
@property (strong, nonatomic) NSMutableAttributedString *gameProcess;

@end
