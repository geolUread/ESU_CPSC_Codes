#if !defined GAMEVIEW_H
#define GAMEVIEW_H

#include"IReadCardList.h"
#include<iostream>
using namespace std;

class gameView
{
private:
	IReadCardList* theDeck;
	IReadCardList* theStack;

public:
	gameView(IReadCardList* x, IReadCardList* y);
	void display();
};
#endif