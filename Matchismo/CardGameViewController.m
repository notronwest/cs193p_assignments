//
//  ViewController.m
//  Matchismo
//
//  Created by Ron West on 11/17/15.
//  Copyright © 2015 Ron West. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameType;
@end

@implementation ViewController

// start a new game
- (IBAction)startNewGame:(UIButton *)sender {
    // create a new game
    _game = [self startGame];
    // re-enable the game type option
    _gameType.enabled = YES;
    // reset the UI
    for(UIButton *cardButton in self.cardButtons){
        // reset the text and images
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        // enable the card
        cardButton.enabled = YES;
    }
    // reset UI for label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
}

- (CardMatchingGame *)game{
    if(!_game) _game = [self startGame];
    return _game;
}
             
- (CardMatchingGame *)startGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] gameType:[_gameType titleForSegmentAtIndex:_gameType.selectedSegmentIndex]];
}

- (PlayingCardDeck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

// handle clicking on a card
- (IBAction)touchCardButton:(UIButton *)sender {
    
    // turn off the option of changing the game type
    _gameType.enabled = NO;
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    // update the UI with the chosen card
    [self updateUI];
    // update the score
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",(int)self.game.score];
}

- (void) updateUI{
    for( UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        // disable a matched card
        cardButton.enabled = !card.isMatched;
    }
}

// set the title for the card
- (NSString *) titleForCard: (Card *) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard: (Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
