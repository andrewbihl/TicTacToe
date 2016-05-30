//
//  WebViewController.m
//  TicTacToe
//
//  Created by Andrew Bihl on 5/30/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    NSURL* directionsURL = [NSURL URLWithString:@"https://web.cecs.pdx.edu/~bart/cs541-fall2001/homework/tictactoe-rules.html"];
    NSURLRequest* directionsRequest = [NSURLRequest requestWithURL:directionsURL];
    [self.webView loadRequest:directionsRequest];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
