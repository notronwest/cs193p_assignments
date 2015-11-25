//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Ron West on 11/18/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        // loop through all of the valid suits
        for( NSString *suit in [PlayingCard validSuits]) {
            // loop through all of the valid ranks
            for( NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++ ){
                // instantiate a Playing Card
                PlayingCard *card = [[PlayingCard alloc] init];
                // set the playing card rank
                card.rank = rank;
                // set the playing card suit
                card.suit = suit;
                // add this card into the playing card array (defined by Deck)
                [self addCard:card];
            }
        }
        
    }
    
    return self;
}

@end
