//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ron West on 11/18/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// override cards match function to allow suit or number
- (int)match:(NSMutableArray *)otherCards{
    int score = 0;
    int cardsMatched = 1;
    // make a copy of the array to do the matching
    NSMutableArray *cardsToMatch = [NSMutableArray arrayWithArray:otherCards];
    // insert this card into the array of cards to check
    [cardsToMatch insertObject:self atIndex:0];
    
    // loop through until we run out of cards
    while([cardsToMatch count] > 0){
        // get the first card out
        PlayingCard *firstCard = [cardsToMatch firstObject];
        // delete this object
        [cardsToMatch removeObjectAtIndex:0];
        // loop through the remaining cards and check
        for( PlayingCard *cardToMatch in cardsToMatch){
            // check suit
            if( firstCard.rank == cardToMatch.rank ){
                score += 4;
                cardsMatched++;
            } else if( firstCard.suit == cardToMatch.suit ){
                score += 1;
                cardsMatched++;
            }
        }
    }
    
    // if we still only have 1 match then we will this card
    if( cardsMatched == 1 && !self.matched ){
        self.chosen = NO;
        // now go through and leave only one card in the passed in array to selected
        for(int i=0; i < [otherCards count] - 1; i++){
            PlayingCard *cardToUnchoose = [otherCards objectAtIndex:i];
            cardToUnchoose.chosen = NO;
        }
    } else {
        // we have atleast one match so mark them all
        self.matched = YES;
        // match all the cards
        for(PlayingCard *matchedCard in otherCards){
            matchedCard.matched = YES;
        }
    }
    
    // apply some bonus for the number of cards matched
    return (score * cardsMatched);
}

- (NSString *) contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide the setter AND the getter

// provides a class method of valid suits which passes by reference
+ (NSArray *) validSuits{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

// returns a class method of valid ranking which passes by reference
+ (NSArray *) rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

// returns a class method of the maximum ranking passed by value
+ (NSUInteger) maxRank{
    return [[self rankStrings] count]-1;
}


// ++ SETTERS/GETTERS ++

// internal getter for suit (sets a default value)
- (NSString *) suit{
    return _suit ? _suit : @"?";
}


// internal setter for suit (makes sure its valid)
- (void)setSuit:(NSString *)suit{
    if( [[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

// internal setter for rank (makes sure its not above the valid max rank)
- (void)setRank:(NSUInteger)rank{
    if( rank <= [PlayingCard maxRank] ){
        _rank = rank;
    }
}

@end
