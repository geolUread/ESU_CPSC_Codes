#include"card.h"
//This constructor creates a card object with a value; rank
card::card()
{
		 rank = 0;
}

card::card(int r)
{
		 rank = r;
}

//This function will return the value; rank of the card object
int card::getRank()
{
		 return rank;
}