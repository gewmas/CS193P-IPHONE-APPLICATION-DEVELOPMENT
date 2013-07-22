//
//  SetGameViewController.m
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "SetGameViewController.h"
#import "PlayingSetDeck.h"
#import "SetMatchingGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) SetMatchingGame *game;

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *matchResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameProcessLabel;


@end

@implementation SetGameViewController

- (void)viewDidLoad
{
    [self updateUI];
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (SetMatchingGame *)game
{
    
    if (!_game){
        _game = [[SetMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingSetDeck alloc] init]];
        //NSLog(@"cardbuttons count %d", self.cardButtons.count);
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
//        NSLog(@"%d", [self.cardButtons indexOfObject:cardButton]);
//                [cardButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"af"] forState:UIControlStateSelected];
        Card *set = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    
//        NSLog(@"%d %@ %@",set.isFaceUp, set.contents, set.attribtedContents);
        [cardButton setAttributedTitle:set.attribtedContents forState:UIControlStateSelected];
        [cardButton setAttributedTitle:set.attribtedContents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = !set.isFaceUp;
//        cardButton.selected = NO;
        cardButton.enabled = !set.isUnplayable;
        cardButton.alpha = set.isUnplayable ? 0.3 : 1.0;
        cardButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    [self.gameProcessLabel setAttributedText:self.game.gameProcess];
    [self.matchResultLabel setAttributedText:self.game.resultOfLastFlip];
//    self.gameProcessLabel.attributedText = self.game.gameProcess;
//    self.matchResultLabel.attributedText = self.game.resultOfLastFlip;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}
- (IBAction)flip:(UIButton *)sender {
    [self.game flipSetAtIndex:[self.cardButtons indexOfObject:sender]];
    
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealGame {
    self.game = nil;
    
    self.flipCount = 0;
    [self.game restartGame];
    [self updateUI];
}


@end
