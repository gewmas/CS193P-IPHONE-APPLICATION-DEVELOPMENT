//
//  SetMatchingGame.m
//  Set
//
//  Created by Yuhua Mai on 7/16/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "SetMatchingGame.h"

@implementation SetMatchingGame

@synthesize cards = _cards;

- (NSMutableArray *)cards
{
    if (!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

@end
