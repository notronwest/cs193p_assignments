//
//  Card.h
//  Matchismo
//
//  Created by Ron West on 11/17/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(NSArray*)otherCards;

@end