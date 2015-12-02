//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ron West on 11/20/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *chosenCards; // of Card
@property (nonatomic, readwrite) NSInteger cardsToMatch;
@end

@implementation CardMatchingGame

// getter for building the instance variable of chosen cards
-(NSMutableArray *)chosenCards{
    if(!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

// getter for building the instance variable cards
-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck gameType:(NSString *)gameType{
    
    self = [super init];
    
    if(self){
        for(int i=0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            } else { // if they ask for more cards then are available
                self = nil; // set this object to "nil" cause its broken
                break;
            }
        }
    }
    
    // set the number of cards to match
    _cardsToMatch = [[gameType componentsSeparatedByString: @" "][0] integerValue];
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

/* MATCHING LOGIC

    2 Card Game
    - only match two cards (when you get to those 2 cards break out
    - match both suits = 1
    - match both numbers = 4
 
    3 Card Game
    - only match three cards (when you get to those 3 cards break out)
    - match all three suits = 8
    - match all three numbers = 20
    - match 2 suits (mismatch 3rd) = 4
    - match 2 numbers (mismatch 3rd) = 10
 
*/
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    // if a card is matched then it can't be chosen (UI should prevent this)
    if(!card.isMatched){
        // if this card is already chosen - then unchoose it
        if(card.isChosen){
            card.chosen = NO;
        } else {
            // add this card into the array of chosen cars
            [self.chosenCards addObject:card];
            // mark it as chosen (NOTE: may not need to do that anymore)
            card.chosen = YES;
            // it costs to play
            self.score -= COST_TO_CHOSE;
            // handle the scoring if we have the correct number of cards
            if( [self.chosenCards count] == self.cardsToMatch){
                // get the first card out and start matching (this will essentially be the first card chosen in this turn)
                Card *firstCard = [self.chosenCards firstObject];
                // remove this card
                [self.chosenCards removeObjectAtIndex:0];
                // start matching
                int matchScore = [firstCard match:self.chosenCards];
                // at least 2 of the cards have matched
                if( matchScore ){
                    self.score += matchScore * MATCH_BONUS;
                    // clear all of these from the chosen
                    [self.chosenCards removeAllObjects];
                } else { // apply penalty for picking incorrectly
                    self.score -= MISMATCH_PENALTY;
                    // now go through and leave only one card in the passed in array to selected
                    for(int i=0; i < [self.chosenCards count] - 1; i++){
                        [self.chosenCards removeObjectAtIndex:i];
                    }
                }
            }
        }
    }

}


@end
