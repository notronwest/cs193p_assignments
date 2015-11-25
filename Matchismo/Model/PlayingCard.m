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
    // loop through the other cards and match them
    for(PlayingCard *otherCard in otherCards){
        // if the card matches add the score
        if( self.rank == otherCard.rank ){
            score += 4;
            cardsMatched++;
            // set both cards as matched
            self.matched = YES;
            otherCard.matched = YES;
        } else if( self.suit == otherCard.suit ){
            score += 1;
            cardsMatched++;
            self.matched = YES;
            otherCard.matched = YES;
        }
    }
    // now pop off the last item and match this against the rest of the cards
    while( [otherCards count] > 1 ){
        // get last one
        Card *thisCard = [otherCards firstObject];
        // remove this from the array
        [otherCards removeLastObject];
        // rescore these
        score = [thisCard match:otherCards];
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
