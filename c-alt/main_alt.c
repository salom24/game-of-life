// Alternative version with infinite board

#include <stdio.h>
#include <stdlib.h>

// Definitions for lists
typedef struct cell cell;

typedef struct cell {
	int x;
	int y;
	int value;
	cell * previous;
	cell * next;
} cell;

typedef struct list {
	int n;
	cell * first;
	cell * last;
} list;

list * new() {
	struct list * ls = malloc(sizeof(list));
	ls->n = 0;
	ls->first = 0;
	ls->last = 0;
	return ls;
}


cell * chk(list * ls, int x, int y) {
	cell * it = ls->first;
	while (it != 0) {
		if (it->x == x && it->y == y) {
			return it;
		}
		it = it->next;
	}
	return 0;
}

int add(list * ls, int x, int y, int value) {
	if (chk(ls, x, y)) {
		(chk(ls, x, y))->value = value;
		return ls->n;
	} else {
		cell * c = malloc(sizeof(cell));
		c->x = x;
		c->y = y;
		c->value = value;
		c->next = 0;
		ls->last = c;
		cell * it = ls->first;
		if(ls->n > 0) {
			while (it->next != 0) {
				it = it->next;
			}
			it->next = c;
			c->previous = it;
		} else {
			ls->first = c;
			c->previous = 0;
		}
		ls->n += 1;
		return ls->n;
	}
}

int rm(list * ls, int x, int y) {
	cell * it = ls->first;
	while (it != 0) {
		if (it->x == x && it->y == y) {
			if (it->previous != 0) {
				(it->previous)->next = it->next;
			} else {
				ls->first = it->next;
			}
			if (it->next != 0) {
				(it->next)->previous = it->previous;
			} else {
				ls->last = it->previous;
			}
			ls->n -= 1;
		}
		it = it->next;
	}
	free(it);
	return ls->n;
}

void erase(list * ls) {
	while (ls->n != 0) {
		rm(ls, (ls->last)->x, (ls->last)->y);
	}
	free(ls);
}

// Life cells
void iteration(list * ls) {
	list * neighbours = new();
	cell * it = ls->first;
	while (it != 0) {
		for (int x = it->x-1; x <= it->x+1; x++) {
			for (int y = it->y-1; y <= it->y+1; y++) {
				cell * probe = chk(neighbours, x, y);
				if (x != it->x && y != it->y) {
					if (probe) {
						probe->value += 1;
					} else {
						add(neighbours, x, y, 1);
					}
				} else {
					if (!probe) {
						add(neighbours, x, y, 0);
					}
				}
			}
		}
		it = it->next;
	}
	it = neighbours->first;
	while (it != 0) {
		if (it->value == 3) {
			add(ls, it->x, it->y, 1);
		} else if (it->value == 2 && chk(ls, it->x, it->y)) {
			add(ls, it->x, it->y, 1);
		} else {
			rm(ls, it->x, it->y);
		}
		it = it-> next;
	}
	erase(neighbours);
}

void print(list * ls) {
	cell * it = ls->first;
	printf("Iteration:\n");
	while (it != 0) {
		printf("%d/%d\n", it->x, it->y);
		it = it->next;
	}
}

int main(int argc, char const *argv[]) {
	list * game = new();
	add(game, 5, 5, 1);
	add(game, 6, 6, 1);
	add(game, 6, 5, 1);
	add(game, 4, 6, 1);
	while (1) {
		print(game);
		iteration(game);
	}
	return 0;
}
