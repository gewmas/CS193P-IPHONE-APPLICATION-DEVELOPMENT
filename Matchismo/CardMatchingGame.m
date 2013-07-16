//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Yuhua Mai on 7/2/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) int roundsPlayed;

@property (nonatomic) NSString *myResultOfLastFlip;

@property (nonatomic) NSMutableArray *myArray;

@property (nonatomic) NSMutableArray *playedGameData;

@property (nonatomic) int prevRoundChanged;
@end

@implementation CardMatchingGame

- (NSString*) myResultOfLastFlip
{
    if (!_myResultOfLastFlip) {
        _myResultOfLastFlip = @"Result of last flip will appear here.";
    }
    return _myResultOfLastFlip;
}

- (NSMutableArray *)playedGameData
{
    if (!_playedGameData) {
        _playedGameData = [[NSMutableArray alloc] init];
        NSMutableArray *currentMutableArray = [[NSMutableArray alloc] init];
        [_playedGameData addObject:currentMutableArray];
    }
    return _playedGameData;
}

- (NSMutableArray *)cards
{
    if (!_cards){
        _cards = [[NSMutableArray alloc] init];
        _myArray = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index chooseMode:(NSUInteger)mode
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            if(![self checkAvailableMove:card currentIndex:index]){
                self.myResultOfLastFlip = [@"Flipped up " stringByAppendingString:card.contents];
                return;
            }
        }
    }
    
    if(mode == 0)
        [self flipForTwoCards:index];
    else
        [self flipForThreeCards:index];
}

- (void)flipForTwoCards:(NSUInteger)index
{
    int firstIndex = index;
    int secondIndex = 0;
    
    Card *card = [self cardAtIndex:index];
    int matchScore = 0;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            //see if flipping this card up creates a match
            for (Card *otherCard in self.cards){
//                secondIndex++;
                
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        //                        NSLog(@"After card unplayable");
                        self.score += matchScore * MATCH_BONUS;
                        
                        self.myResultOfLastFlip = [@"Matched" stringByAppendingFormat:@" %@ & %@ for %d points", card.contents, otherCard.contents, matchScore];
                        
                        NSMutableArray *gameDataForCurrentRound = [[NSMutableArray alloc] init];
//                        [gameDataForCurrentRound addObject:[NSString stringWithFormat:@"%d", firstIndex]];
//                        [gameDataForCurrentRound addObject:[NSString stringWithFormat:@"%d", secondIndex]];
                        [gameDataForCurrentRound addObject:card];
                        [gameDataForCurrentRound addObject:otherCard];
                        
                        [self successfulRound:gameDataForCurrentRound];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
    
}

- (void)flipForThreeCards:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *cardIndex = [NSString stringWithFormat:@"%d", index];
    int i = [self.myArray indexOfObject:[self.myArray lastObject]];
    
    if(i != 2){
        if([self.myArray containsObject:cardIndex])
            [self.myArray removeObject:cardIndex];
        else
            [self.myArray addObject:cardIndex];
    }
    
    i = [self.myArray indexOfObject:[self.myArray lastObject]];
    
    if(i == 2){
        NSLog(@"third card");
        int firstIndex = [self.myArray[0] integerValue];
        int secondIndex = [self.myArray[1] integerValue];
        int thirdIndex = [self.myArray[2] integerValue];
        
        [self.myArray removeAllObjects];
        
        Card *card1 = [self cardAtIndex:firstIndex];
        Card *card2 = [self cardAtIndex:secondIndex];
        Card *card3 = [self cardAtIndex:thirdIndex];
        
        int matchScore1 = [card1 match:@[card2]];
        int matchScore2 = [card1 match:@[card3]];
        int matchScore3 = [card2 match:@[card3]];
        
        if(matchScore1 && matchScore2 && matchScore3){
            int matchScore = matchScore1 + matchScore2 + matchScore3;
            self.score = matchScore;
            
            card1.unplayable = YES;
            card1.faceUp = YES;
            card2.unplayable = YES;
            card2.faceUp = YES;
            card3.unplayable = YES;
//            card3.faceUp = YES;
            
            self.myResultOfLastFlip = [@"" stringByAppendingFormat:@" %@ & %@ & %@ for %d points", card1.contents, card2.contents, card3.contents, matchScore];
            
            NSMutableArray *gameDataForCurrentRound = [[NSMutableArray alloc] init];
//            [gameDataForCurrentRound addObject:[NSString stringWithFormat:@"%d", firstIndex]];
//            [gameDataForCurrentRound addObject:[NSString stringWithFormat:@"%d", secondIndex]];
//            [gameDataForCurrentRound addObject:[NSString stringWithFormat:@"%d", thirdIndex]];
            [gameDataForCurrentRound addObject:card1];
            [gameDataForCurrentRound addObject:card2];
            [gameDataForCurrentRound addObject:card3];
            
            [self successfulRound:gameDataForCurrentRound];
        } else {
            self.score -= MISMATCH_PENALTY;
            
            card1.faceUp = NO;
            card2.faceUp = NO;
            card3.faceUp = NO;
            
            [self.myArray addObject:cardIndex];
        }
        
        self.score -= FLIP_COST;
    }
    
    card.faceUp = !card.isFaceUp;
    
}

- (void) successfulRound : (NSMutableArray *) myArray
{

    self.roundsPlayed++;
    [self.playedGameData addObject:myArray];
    
    NSLog(@"Current round %d %d", [self.playedGameData indexOfObject: self.playedGameData.lastObject], self.roundsPlayed);
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (bool)checkAvailableMove:(Card *)card currentIndex:(NSInteger)index
{
    bool hasNoMatch = true;
    bool hasCardFaceUp = false;
    
    for(Card *otherCard in self.cards){
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
            hasCardFaceUp = true;
        }
    }
    
    if (!hasCardFaceUp) {
        for(Card *otherCard in self.cards){
            if (!otherCard.isFaceUp && !otherCard.isUnplayable && card != otherCard) {
                int match = [card match:@[otherCard]];
                if (match != 0) {
                    hasNoMatch = false;
                }
            }
        }
        
        if (hasNoMatch) {
            card.unplayable = YES;
            card.faceUp = YES;
            
            NSMutableArray *gameDataForCurrentRound = [[NSMutableArray alloc] init];
//            [gameDataForCurrentRound addObject:[NSString stringWithFormat:@"%d", index]];
            [gameDataForCurrentRound addObject:card];
            
            [self successfulRound:gameDataForCurrentRound];
            
            return false;
        }
    }
    
    return true;
}

- (NSString*)updateResultOfLastFlip
{
    return self.myResultOfLastFlip;
}

- (void)restartGame
{
    self.myResultOfLastFlip = @"Result of last flip will appear here.";
    self.score = 0;
    for(Card *otherCard in self.cards){
        otherCard.faceUp = NO;
        otherCard.unplayable = NO;
    }
}

- (void)changeGameStatus:(NSUInteger)round
{
    if (round == self.prevRoundChanged) {
        return;
    }
    self.prevRoundChanged = round;
    
    NSLog(@"Last round %d %d", [self.playedGameData indexOfObject: self.playedGameData.lastObject], (int)round);
    
//    NSLog(@"SizeOfRoundData %d", sizeOfRoundData);
    
    for(Card *otherCard in self.cards){
        otherCard.faceUp = NO;
        otherCard.unplayable = NO;
    }

    for (int i = 1; i <= (int)round; ++i) {
        NSMutableArray *roundData = self.playedGameData[i];
        int sizeOfRoundData = [roundData indexOfObject:[roundData lastObject]];
//        NSLog(@"sizeOfRoundData %d", sizeOfRoundData);
        for (int j = 0; j < sizeOfRoundData+1; ++j) {
//            NSLog(@"clear card:%d", [roundData[j] integerValue]);
//            Card *card = [self cardAtIndex:[roundData[j] integerValue]];
            Card *card = roundData[j];
//
            card.faceUp = YES;
            card.unplayable = YES;
        }
    }
}

@end
