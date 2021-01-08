#include"gameView.h"

gameView::gameView(IReadCardList* x, IReadCardList* y)
{
	//We move the object into objects in the class to handle the interface functions
	theDeck = x;
	theStack = y;
}

void gameView::display()
{
	//This will print out the 1st list in deck
	card* checkDeck =  theDeck->getFirst();
	cout << "1st List: ";
	while (checkDeck->getRank() != -1)
	{
		cout << checkDeck->getRank() << " ";
		checkDeck = theDeck->getNext();
	}

	//This will print out the 2nd list in stack 
	cout << "    " << "2nd List: ";
	card* checkStack = theStack->getFirst();
	while (checkStack->getRank() != -1)
	{
		cout <<checkStack->getRank() << " ";
		checkStack = theStack->getNext();
	}
	cout << endl;
}