//
//  ViewController.m
//  TicTacToe
//
//  Created by Paul Lefebvre on 5/26/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//Board values. 0=none, 1=first player, 2=second player
@property NSMutableArray* boardValues;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property bool firstPlayersTurn;
@property NSArray* winningSets;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.boardValues = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,nil];
    self.winningSets = [self getSetOfWinningSets];
    self.firstPlayersTurn = true;
    self.whichPlayerLabel.text = @"x";
    self.whichPlayerLabel.textColor = [UIColor blueColor];
    NSLog(@"%@",self.boardValues);
}

-(NSArray*)getSetOfWinningSets{
    NSMutableArray* result = [NSMutableArray new];
    [result addObject: [NSSet setWithObjects:@0,@1,@2, nil]];
    [result addObject: [NSSet setWithObjects:@3,@4,@5, nil]];
    [result addObject: [NSSet setWithObjects:@6,@7,@8, nil]];
    [result addObject: [NSSet setWithObjects:@0,@4,@8, nil]];
    [result addObject: [NSSet setWithObjects:@2,@4,@6, nil]];
    [result addObject: [NSSet setWithObjects:@0,@3,@6, nil]];
    [result addObject: [NSSet setWithObjects:@1,@4,@7, nil]];
    [result addObject: [NSSet setWithObjects:@2,@5,@8, nil]];
    
    return result;
}

-(NSString*)whoWon{
    
    NSMutableSet* xSpots = [NSMutableSet new];
    NSMutableSet* oSpots = [NSMutableSet new];
    
    for (int i = 0; i < self.boardValues.count; i++){
        NSNumber* x = [self.boardValues objectAtIndex:i];
        if ( x.integerValue>0){
            if (x.integerValue==1)
                [xSpots addObject:[NSNumber numberWithInteger:i]];
            else
                [oSpots addObject:[NSNumber numberWithInteger:i]];
        }
    }
    
    for (NSSet* set in self.winningSets){
        if ([set isSubsetOfSet:xSpots])
            return @"PLAYER 1";
        else if ([set isSubsetOfSet:oSpots])
            return @"PLAYER 2";
    }
    return @"No";
}

- (void)winAlert:(NSString *)winner{
    if (![winner isEqualToString:@"No"]) {
        UIAlertController *win = [UIAlertController alertControllerWithTitle:@"WINNER!" message:[NSString stringWithFormat:@"%@ Wins! Congratulations!",winner] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *startOver = [UIAlertAction actionWithTitle:@"New Game?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self resetBoard];
        }];
        [win addAction:startOver];
        [self presentViewController:win animated:YES completion:nil];
    }
    
}

- (void)resetBoard{
    [self.button1 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button2 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button3 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button4 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button5 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button6 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button7 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button8 setTitle:@"" forState:(UIControlStateNormal)];
    [self.button9 setTitle:@"" forState:(UIControlStateNormal)];

    self.boardValues = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,nil];
    self.firstPlayersTurn = true;
    self.whichPlayerLabel.text = @"x";
    self.whichPlayerLabel.textColor = [UIColor blueColor];
}

- (IBAction)onButtonPushed:(UIButton *)sender {
    int boardIndex = [sender.restorationIdentifier integerValue];
    if (self.firstPlayersTurn) {
        [self.boardValues replaceObjectAtIndex:boardIndex withObject:@1];
        [sender setTitle:@"x" forState:UIControlStateNormal];
        self.whichPlayerLabel.text = @"o";
        self.whichPlayerLabel.textColor = [UIColor redColor];
    }
    else {
        [self.boardValues replaceObjectAtIndex:boardIndex withObject:@2];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sender setTitle:@"o" forState:UIControlStateNormal];
        self.whichPlayerLabel.text = @"x";
        self.whichPlayerLabel.textColor = [UIColor blueColor];
    }
    NSLog(@"%@",self.boardValues);
    [self winAlert:[self whoWon]];
    self.firstPlayersTurn = !self.firstPlayersTurn;
}

@end
