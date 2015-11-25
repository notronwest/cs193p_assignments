//
//  Card.m
//  Matchismo
//
//  Created by Ron West on 11/17/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    for( Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    return score;
}

@end
