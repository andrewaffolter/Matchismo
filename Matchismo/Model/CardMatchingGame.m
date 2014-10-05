//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andrew Affolter on 2/13/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic, readwrite) NSArray *lastChosenCards;
@property (nonatomic, readwrite)NSInteger lastScore;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSInteger)numberOfCardsToMatch
{
    if(_numberOfCardsToMatch < 2)
    {
        _numberOfCardsToMatch = 2;
    }
    return _numberOfCardsToMatch;
}


//designated initalizer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; //super's designated initalizer
    
    if(self){
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            //we need to check for nil here in case the deck of cards is empty so we dont' crash the program by trying to add something to a nill array which would raise an array index out of bounds exception.
            if(card)
            {
                [self.cards addObject:card];
            }
            else
            {
                //if we can't initalize the array (deck of cards) then we will return nil
                self = nil;
                break;
            }
            
        }
    
    }
    return  self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    //just returns the card at the current index, but first checks to make sure the argument is not out of bounds
    return (index<[self.cards count]) ? self.cards[index]: nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            
            self.lastScore = 0;
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            
            if ([otherCards count] + 1 == self.numberOfCardsToMatch) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    self.lastScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    self.lastScore = - MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
