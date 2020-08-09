//
//  main.c
//  GameOfLife
//
//  Created by Alejandro Salom on 19/05/14.
//  Copyright (c) 2014 Alejandro Salom. All rights reserved.
//

#include "Game.h"

int main(int argc, const char * argv[])
{

	printf("====This is the game of life!====\n");
	printf("\nPress enter...");
	
	getchar();
	system("clear");
	
	int H , L;
	
	printf("How big do you want it?\n");
	printf("Height: ");
	scanf("%i",&H);
	printf("Lenght: ");
	scanf("%i",&L);
	
	game(H, L);
	
	return 0;
}

