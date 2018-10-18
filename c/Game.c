//
//  Game.c
//  GameOfLife
//
//  Created by Alejandro Salom on 19/05/14.
//  Copyright (c) 2014 Alejandro Salom. All rights reserved.
//

#include "Game.h"

void printtb(int H, int L, int tb[H][L] ,long t){
    
    int x , y;
    system("clear");
    
    for (y=0; y<H; y++){
        for (x=0; x<L ; x++){
            printf(" %c", tb[y][x]==1?'x':' ');
        }
        printf("\n");
    }
    //printf("Turns: %li", t);

    
}


void game(int H , int L){
    
    srand((int) time(NULL));
    int tb[H][L] , x , y ;
    long t;
    char j;
    
    for (y=0; y<H; y++){
        for (x=0; x<L ; x++){
            tb[y][x] = rand()%2;
        }
    }
    t=0;
    do {
        printtb( H , L , tb, t++);
        turn( H , L , tb);
        j = getchar();
    } while ( j != 'p');
    
}


void turn(int H , int L , int tb[H][L]){
    
    int tb2[H][L] , x , xx , y , yy , n;
    
    for (y=0; y<H; y++){
        for (x=0; x<L ; x++){
            n=0;
            for (yy=(y==0?0:(y-1)); yy<=(y==(H-1)?(H-1):(y+1));yy++){
                for (xx=(x==0?0:(x-1)); xx<=(x==(L-1)?(L-1):(x+1));xx++){
                    
                    if (tb[yy][xx]==1) n++;
                    
                }
            }
            if (tb[y][x]==1) {
                n--;
                if (n==2 || n==3){
                    tb2[y][x]=1;
                } else {
                    tb2[y][x]=0;
                }
            } else {
                if (n==3){
                    tb2[y][x]=1;
                } else {
                    tb2[y][x]=0;
                }
            }
            
        }
    }
    for (y=0; y<H; y++){
        for (x=0; x<L ; x++){
            tb[y][x] = tb2[y][x];
        }
    }
    
}
