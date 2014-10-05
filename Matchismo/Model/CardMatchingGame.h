//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andrew Affolter on 2/13/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initalizer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;

-(void) chooseCardAtIndex: (NSUInteger) index;

-(Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) NSInteger numberOfCardsToMatch;

@property (nonatomic, readonly) NSArray*lastChosenCards;

@property(nonatomic, readonly)NSInteger lastScore;

@end
