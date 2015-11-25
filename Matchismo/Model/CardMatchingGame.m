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
    if(!_cards) _cards = [[NSMutableArray alloc]init];
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
            // get all of the other cards selected
            for( Card *otherCard in self.cards ){
                // if this other card is the other chosen card and its not already matched
                if( otherCard.isChosen && !otherCard.isMatched ){
                    // add this to the array of selected cards
                    [_chosenCards addObject:otherCard];
                    // if we are playing a 2 card game we can stop
                    if( self.cardsToMatch == 2){
                        break; // can only choose two cards
                    } else if(self.cardsToMatch == 3 && [_chosenCards count] == 3){
                        break;
                    }
                }
            }
            // handle the scoring if we have atleast 2 cards to match
            if( [_chosenCards count] > 1){
                int matchScore = [card match:_chosenCards];
                if( matchScore ){
                    self.score += matchScore * MATCH_BONUS;
                } else { // apply penalty for picking incorrectly
                    self.score -= MISMATCH_PENALTY;
                }
            }

            // add this into the score
            self.score -= COST_TO_CHOSE;
            card.chosen = YES;
        }
    }

}


@end
