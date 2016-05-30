//
//  AutoPlayer.m
//  TicTacToe
//
//  Created by Andrew Bihl on 5/30/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

#import "AutoPlayer.h"


@implementation AutoPlayer

-(int)makeMove:(NSArray*)boardValues{
    return 9*rand();
}

@end
