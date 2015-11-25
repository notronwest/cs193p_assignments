//
//  Deck.h
//  Matchismo
//
//  Created by Ron West on 11/18/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (BOOL)hasCards;

- (Card *)drawRandomCard;

@end
