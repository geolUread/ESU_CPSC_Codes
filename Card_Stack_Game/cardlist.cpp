#include"cardlist.h"
#include<iostream>
using namespace std;

class Card;

cardlist::cardlist()
{
		 numCards = 0;
		 current_index = 0;
		 for (int i = 0; i < TOTAL; i++)
		 {
					arrayCards[i] = 0;
		 }
}

card* cardlist::getFirst()
{
	if (numCards == 0)
	{
		card* error = new card(-1);
		return error;
	}
	current_index = 1;
	return arrayCards[0];
}

card* cardlist::getNext()
{
	if (current_index == numCards)
	{
		card* error = new card(-1);
		return error;
	}
	else
	{
		card* temp2 = arrayCards[current_index];
		current_index++;
		return temp2;
	}

}

void cardlist::append(card* c)
{
		 arrayCards[numCards] = c;
		 numCards++;
}

card* cardlist::removeLast()
{

	if (numCards == 0)
	{
		card* error = new card(-1);
		return error;
	}
	int last = numCards - 1;
	numCards--;
	return arrayCards[last];
}

bool cardlist::isEmpty()
{
		 if (numCards == 0)
		 {
					return true;
		 }
		 else
		 {
					return false;
		 }
}
