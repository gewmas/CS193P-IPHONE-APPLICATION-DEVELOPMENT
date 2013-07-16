//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Yuhua Mai on 7/2/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController () 
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultOfLastFlip;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UISegmentedControl *switchMode;


//@property (nonatomic) UIAlertView *myAlertView;
@end

@implementation CardGameViewController

//- (Deck *)deck
//{
//    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
//    return _deck;
//}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
//    for (UIButton *cardButton in cardButtons){
//        Card *card = [self.deck drawRandomCard];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected];
//    }
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
//        if (!cardButton.isSelected) {
//            UIImage *cardBackImage = [UIImage imageNamed:@"1.png"];
//            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
//            [cardButton setTitle:nil forState:UIControlStateNormal];
//            [cardButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//        } else {
//            [cardButton setImage:nil forState:UIControlStateNormal];
//        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultOfLastFlip.text = [self.game updateResultOfLastFlip];
    
    
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    self.switchMode.enabled = NO;
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender] chooseMode:self.switchMode.selectedSegmentIndex];
//    sender.selected = !sender.isSelected;
    self.flipCount++;
    [self updateUI];
}

- (IBAction)restartGame:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Restart!" message:@"Your game data will be lost." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [myAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        self.switchMode.enabled = YES;
        [self clearGameData];
    }
}

- (IBAction)performGameSwitch:(UISegmentedControl *)sender {
    [self clearGameData];
}

- (void)clearGameData
{
    _game = nil;
    [self.game restartGame];
    self.flipCount = 0;
    [self updateUI];
}



@end