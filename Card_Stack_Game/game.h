#if !define GAME_H
#define GAME_H

#include<iostream>
using namespace std;
#include "IStack.h"


class game 
{
private:
		 IStack* theDeck;
		 IStack* theStack;
	public:
		game(IStack* x, IStack* y);
		void move();
		void undo();
		bool isEmpty();
};
#endif