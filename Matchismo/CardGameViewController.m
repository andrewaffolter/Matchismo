//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andrew Affolter on 2/9/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation CardGameViewController


-(CardMatchingGame *)game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        [self touchMatchSegmentedControl:self.matchSegmentedControl];
    }
    return _game;
}


-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc ]init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    _matchSegmentedControl.enabled = NO;
    
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    if (self.game) {
        NSString *description = @"";
        
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            
            description = [NSString stringWithFormat:@"%@ don’t match! %d point penalty!", description, -self.game.lastScore];
        }
        
        self.resultLabel.text = description;
    }
}

-(NSString *)titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchStartNewGameButton:(UIButton *)sender
{
    _game = nil;
    [self game];
    [self updateUI];
    self.matchSegmentedControl.enabled = YES;
    _resultLabel.text = @"Results";
}
- (IBAction)touchMatchSegmentedControl:(UISegmentedControl *)sender
{   
    self.game.numberOfCardsToMatch= [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
}


@end
