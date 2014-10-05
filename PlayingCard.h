//
//  PlayingCard.h
//  Matchismo
//
//  Created by Andrew Affolter on 2/10/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property(strong, nonatomic) NSString *suit;
@property(nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
