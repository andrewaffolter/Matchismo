//
//  Deck.h
//  Matchismo
//
//  Created by Andrew Affolter on 2/10/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
