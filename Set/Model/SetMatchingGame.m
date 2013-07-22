//
//  SetMatchingGame.m
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "SetMatchingGame.h"

@interface SetMatchingGame()
@property (nonatomic) int score;
@property (nonatomic) int currentRoundScore;
//@property (strong, nonatomic) NSMutableAttributedString *resultOfLastFlip;
//@property (strong, nonatomic) NSMutableAttributedString *gameProcess;

@property (nonatomic) int flippedNumber;
@property (nonatomic) int cardIndex1;
@property (nonatomic) int cardIndex2;

@end

@implementation SetMatchingGame

@synthesize cards = _cards;

- (NSMutableArray *)cards
{
    if (!_cards){
        self.flippedNumber = 0;
        _resultOfLastFlip = [[NSMutableAttributedString alloc] initWithString:@"Match Results Here."];
        _gameProcess = [[NSMutableAttributedString alloc] initWithString:@"Please click one card."];
        
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

//- (NSMutableAttributedString *)resultOfLastFlip
//{
//    if (!_resultOfLastFlip) {
//        _resultOfLastFlip = [[NSMutableAttributedString alloc] initWithString:@"Match Results Here."];
//    }
//    return _resultOfLastFlip;
//}
//
//- (NSMutableAttributedString *)gameProcess
//{
//    if (!_gameProcess) {
//        _gameProcess = [[NSMutableAttributedString alloc] initWithString:@"Please click one card."];
//    }
//    return _gameProcess;
//}


- (void)flipSetAtIndex:(NSUInteger)index
{
    //[self checkAvailableMove];
    Card *card = [self cardAtIndex:index];
    self.resultOfLastFlip = [[NSMutableAttributedString alloc] initWithString:@"Match Results Here."];
    
    if (self.flippedNumber == 0) {
        self.cardIndex1 = index;
        self.flippedNumber = 1;
        
        self.gameProcess = [[NSMutableAttributedString alloc] initWithString:@"Choosing: "];
        [self.gameProcess appendAttributedString:card.attribtedContents];
    } else if(self.flippedNumber == 1){
        self.cardIndex2 = index;
        
        if (self.cardIndex1 == self.cardIndex2) {
            //self.cardIndex1 = self.cardIndex2;
            self.flippedNumber = 1;
            
            self.gameProcess = [[NSMutableAttributedString alloc] initWithString:@"Choosing: "];
            [self.gameProcess appendAttributedString:card.attribtedContents];
        }else{
            self.flippedNumber = 2;
            [self.gameProcess appendAttributedString:[[NSAttributedString alloc] initWithString:@" && "]];
            [self.gameProcess appendAttributedString:card.attribtedContents];
        }
    } else{
        if (self.cardIndex1 == self.cardIndex2 || self.cardIndex1 == index || self.cardIndex2 == index) {
            if (self.cardIndex2 == index) {
                self.cardIndex1 = index;
            }
            self.flippedNumber = 1;
            
            self.gameProcess = [[NSMutableAttributedString alloc] initWithString:@"Choosing: "];
            [self.gameProcess appendAttributedString:card.attribtedContents];
        } else {
            [self.gameProcess appendAttributedString:[[NSAttributedString alloc] initWithString:@" && "]];
            [self.gameProcess appendAttributedString:card.attribtedContents];
            
            [self flipForThreeCards:self.cardIndex1 secondCard:self.cardIndex2 thirdCard:index];
            self.flippedNumber = 0;
        }
    }
}


- (void)flipForThreeCards:(NSUInteger)index1 secondCard:(NSUInteger)index2 thirdCard:(NSUInteger)index3
{
    //NSLog(@"1:%d 2:%d 3:%d", (int)index1, (int)index2, (int)index3);
    
    Card *card1 = [self cardAtIndex:index1];
    Card *card2 = [self cardAtIndex:index2];
    Card *card3 = [self cardAtIndex:index3];
    
    if ([self checkThreeCardMatch:card1 secondCard:card2 thirdCard:card3]) {
        card1.unplayable = YES;
        card2.unplayable = YES;
        card3.unplayable = YES;
        
        self.score += self.currentRoundScore;
        
        self.resultOfLastFlip = [[NSMutableAttributedString alloc] initWithString:@"Match! "];
        [self.resultOfLastFlip appendAttributedString:self.gameProcess];
    } else {
        self.score -= 2;
        
        self.resultOfLastFlip = [[NSMutableAttributedString alloc] initWithString:@"Don't match!"];
        [self.resultOfLastFlip appendAttributedString:self.gameProcess];
        
        self.gameProcess = [[NSMutableAttributedString alloc] initWithString:@"Choosing: "];
        [self.gameProcess appendAttributedString:card3.attribtedContents];
        
        self.cardIndex1 = index3;
        self.cardIndex2 = -1;
        self.flippedNumber = 1;
        
    }
}

- (void)checkAvailableMove
{
    int score = self.score;
    BOOL avaibleMoveForCard1 = false;
    for (Card *card1 in self.cards){
        for (Card *card2 in self.cards){
            for (Card *card3 in self.cards){
                if (![self checkThreeCardMatch:card1 secondCard:card2 thirdCard:card3]) {
                    avaibleMoveForCard1 = true;
                }
            }
        }
        
        if (!avaibleMoveForCard1) {
            card1.unplayable = YES;
        }
    }
    self.score = score;
}

- (BOOL)checkThreeCardMatch:(Card*)card1 secondCard:(Card*)card2 thirdCard:(Card*)card3
{
    int matchScore = [card1 match:@[card2, card3]];
    
    if (matchScore == 0) {
        return false;
    } else {
        self.currentRoundScore = matchScore;
        return true;
    }
}

- (void)restartGame
{
    self.resultOfLastFlip = [[NSMutableAttributedString alloc] initWithString:@"Match Results Here."];
    self.gameProcess = [[NSMutableAttributedString alloc] initWithString:@"Please click one card."];
    
    for (Card *card in self.cards){
        card.unplayable = NO;
    }
    
    self.score = 0;
}

@end
