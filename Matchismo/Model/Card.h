//
//  Card.h
//  Matchismo
//
//  Created by Andrew Affolter on 2/10/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(strong,nonatomic) NSString *contents;

@property(nonatomic,getter = isChosen) BOOL chosen;
@property(nonatomic,getter = isMatched)BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
