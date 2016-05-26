//
//  ViewController.m
//  TicTacToe
//
//  Created by Paul Lefebvre on 5/26/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
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
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property bool firstPlayersTurn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.whichPlayerLabel.text = @"x";
}

- (IBAction)onButtonPushed:(UIButton *)sender {
    self.firstPlayersTurn = !self.firstPlayersTurn;
    if (self.firstPlayersTurn) {
        self.whichPlayerLabel.text = @"x";
    } else {
        self.whichPlayerLabel.text = @"o";
    }
    if (self.firstPlayersTurn == YES) {
        [sender setTitle:@"x" forState:UIControlStateNormal];
    } else {
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sender setTitle:@"o" forState:UIControlStateNormal];
    }
    
}

@end
