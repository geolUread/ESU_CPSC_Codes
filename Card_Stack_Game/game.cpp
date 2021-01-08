#include "game.h"

game::game(IStack* deck, IStack* stack)
{
		 theDeck = deck;
		 theStack = stack;
}

void game::move()
{
	//Move from deck to stack 
	card* moveDeck = theDeck->pop();
	if (moveDeck->getRank() == -1)
	{
		cout << "NO MORE CARDS" << endl;
	}
	else
	{
		theStack->push(moveDeck);
	}

}

void game::undo()
{
	//Move from stack to deck 
	card* moveStack = theStack->pop();
	if (moveStack->getRank() == -1)
	{
		theDeck->isEmpty();
	}
	else
	{
		theDeck->push(moveStack);
	}
}

bool game::isEmpty()
{
	if (theDeck->isEmpty())
	{
		cout << "THE DECK IS EMPTY" << endl;
		return true;
	}
	else if(theStack->isEmpty())
	{
		cout << "THE STACK IS EMPTY" << endl;
		return true;
	}
	else
	{
		return false;
	}
}