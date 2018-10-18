//
//  Game.h
//  GameOfLife
//
//  Created by Alejandro Salom on 19/05/14.
//  Copyright (c) 2014 Alejandro Salom. All rights reserved.
//

#ifndef GameOfLife_Game_h
#define GameOfLife_Game_h

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void printtb(int H, int L, int tb[H][L] , long t);
void game(int H , int L);
void turn(int H , int L , int tb[H][L]);

#endif
