//
//  PlayingCard.m
//  Matchismo
//
//  Created by Andrew Affolter on 2/10/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    int numOtherCards = [otherCards count];
    
    if(numOtherCards)
    {
        for (PlayingCard *card in otherCards)
        {
            PlayingCard *otherCard = card;
            if(otherCard.rank == self.rank){
                score += 4;
            }else if ([otherCard.suit isEqualToString:self.suit])
            {
                score += 1;
            }
        }
        
    }
    if (numOtherCards > 1)
    {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]];
    }
    
    return score;
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return[rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; //because we provide setter AND getter


+(NSArray *)validSuits
{
    return @[@"♥️",@"♦️",@"♠︎",@"♣️"];
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
