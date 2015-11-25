//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ron West on 11/18/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

// defines an instance variable with
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

// defines a publically available method that returns valid suits
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
