//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ron West on 11/20/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)setGameType:(NSString *)setGameType;

@property (nonatomic, readonly) NSUInteger score;

@end
