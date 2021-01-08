#if !defined DECK_H
#define DECK_H

#include "card.h"
#include"SStack.h"
#include<iostream>
using namespace std;

//The Deck class inherits the SStack and Card
class deck : public card, public SStack
{
		 public:
					deck(int x);
					void viewDeck();
};
#endif

//When a deck is created the superclass is also created prior to it being created.