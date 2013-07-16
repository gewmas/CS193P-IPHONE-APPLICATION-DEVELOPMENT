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
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetGameViewController

- (void)viewDidLoad
{
    //[self updateUI];
}

- (SetMatchingGame *)game
{
    NSLog(@"cardbuttons count %d", self.cardButtons.count);
    if (!_game) _game = [[SetMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingSetDeck alloc] init]];
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
        NSLog(@"%d", [self.cardButtons indexOfObject:cardButton]);
//                [cardButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"af"] forState:UIControlStateSelected];
        Card *set = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    
        NSLog(@"%d %@ %@",set.isFaceUp, set.contents, set.attribtedContents);
        [cardButton setAttributedTitle:set.attribtedContents forState:UIControlStateSelected];
        [cardButton setAttributedTitle:set.attribtedContents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = !set.isFaceUp;
        cardButton.enabled = !set.isUnplayable;
        cardButton.alpha = set.isUnplayable ? 0.3 : 1.0;
    }
}
- (IBAction)flip:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
