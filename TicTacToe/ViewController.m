//
//  ViewController.m
//  TicTacToe
//
//  Created by Andrew Bihl on 5/26/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UILabel *marker;
@property CGPoint markerCenter;
@property NSArray* buttons;
//Board values. 0=none, 1=first player, 2=second player
@property NSMutableArray* boardValues;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property bool firstPlayersTurn;
@property NSArray* winningSets;

@end

@implementation ViewController

- (void)viewDidLoad {
    //    CGRect rect = CGRectMake(self.button1.frame.origin.x + self.button1.frame.size.width, 145, 6, 320);
    //    UIView* rectView = [[UIView alloc]initWithFrame:rect];
    //    rectView.backgroundColor = [UIColor blackColor];
    //    [self.view addSubview:rectView];
    
    [super viewDidLoad];
    self.buttons = [NSArray arrayWithObjects:self.button1,self.button2,self.button3,self.button4,self.button5,self.button6,self. button7,self.button8,self.button9, nil];
    self.boardValues = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,nil];
    self.winningSets = [self getSetOfWinningSets];
    [self setTurn:true];
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

-(void)setTurn:(BOOL)forPlayerOne{
    if (forPlayerOne){
        self.firstPlayersTurn = true;
        self.whichPlayerLabel.textColor = [UIColor blueColor];
        self.whichPlayerLabel.text = @"Player 1's Turn";
        self.marker.textColor = [UIColor blueColor];
        self.marker.text = @"x";
    }
    else{
        self.firstPlayersTurn = false;
        self.whichPlayerLabel.textColor =[UIColor redColor];
        self.whichPlayerLabel.text = @"Player 2's Turn";
        self.marker.textColor = [UIColor redColor];
        self.marker.text = @"o";
    }
}

-(void)evaluateDragFinish:(CGPoint)finishLocation{
    
    
    if (finishLocation.x > self.button1.frame.origin.x && finishLocation.x < self.button9.frame.origin.x+self.button9.frame.size.width
        && finishLocation.y > self.button1.frame.origin.y && finishLocation.y < self.button9.frame.origin.y+self.button9.frame.size.height)
    {
        int column;
        int row;;
        if (finishLocation.x > self.button1.frame.origin.x + self.button1.frame.size.width){
            if (finishLocation.x < self.button9.frame.origin.x)
                column = 1;
            else
                column = 2;
        }
        else
            column = 0;
        
        if (finishLocation.y > self.button1.frame.origin.y + self.button1.frame.size.height){
            if (finishLocation.y < self.button9.frame.origin.y)
                row = 1;
            else
                row = 2;
        }
        else
            row = 0;
        int finalValue = (3*row)+column;
        [self markSpot:[self.buttons objectAtIndex:finalValue]];
        
        
    }
    else{
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.marker.center = self.markerCenter;} completion:nil];
    }
    
}

- (IBAction)dragMarkAction:(UIPanGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
        self.markerCenter = self.marker.center;
    CGPoint change = [sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + change.x, sender.view.center.y + change.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];

    if (sender.state == UIGestureRecognizerStateEnded)
        [self evaluateDragFinish:sender.view.center];
    NSLog(@"%f, %f",sender.view.center.x,sender.view.center.y);
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
    if (xSpots.count + oSpots.count == 9)
        return @"Tie";
    return @"No";
}

- (void)winAlert:(NSString *)winner{
    UIAlertController* resultMessage = [UIAlertController alertControllerWithTitle:@"Tie" message:@"You both suck!" preferredStyle:UIAlertControllerStyleAlert];
    
    if (![winner isEqualToString:@"Tie"]){
        resultMessage = [UIAlertController alertControllerWithTitle:@"WINNER!" message:[NSString stringWithFormat:@"%@ Wins! Congratulations!",winner] preferredStyle:UIAlertControllerStyleAlert];
    }
    
    UIAlertAction *startOver = [UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resetBoard];
    }];
    [resultMessage addAction:startOver];
    [self presentViewController:resultMessage animated:YES completion:nil];
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
    [self setTurn:true];
}

- (IBAction)onButtonPushed:(UIButton *)sender {
    [self markSpot:sender];
}

-(void)markSpot:(UIButton*)sender{
    NSInteger boardIndex = [sender.restorationIdentifier integerValue];
    if ([[self.boardValues objectAtIndex:boardIndex] integerValue] >0)
        return;
    if (self.firstPlayersTurn) {
        [self.boardValues replaceObjectAtIndex:boardIndex withObject:@1];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [sender setTitle:@"x" forState:UIControlStateNormal];
        [self setTurn:false];
    }
    else {
        [self.boardValues replaceObjectAtIndex:boardIndex withObject:@2];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sender setTitle:@"o" forState:UIControlStateNormal];
        [self setTurn:true];
    }
    NSLog(@"%@",self.boardValues);
    NSString* winMessage = [self whoWon];
    if (![winMessage isEqualToString:@"No"])
        [self winAlert:winMessage];
}

@end

