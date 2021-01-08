#include <string>
#include <iostream>
#include "SStack.h"
#include "deck.h"
#include "game.h"
#include "gameView.h"

using namespace std;

int main(int argc, char* argv[]) {

	SStack* destStack = new SStack();
	deck* sourceStack = new deck(10); // put 10 cards in the deck

	game game(sourceStack, destStack);
	gameView view(sourceStack, destStack);

	bool done = false;
	string command;

	while (!done) 
	{
		cout << "Please enter a command:" << endl;
		cout << "\tShow the game state (s)" << endl;
		cout << "\tMove a card to the stack (m)" << endl;
		cout << "\tUndo the last move (u)" << endl;
		cout << "\tQuit (q)" << endl;
		std::cin >> command;

		if (command == "s") view.display();
		else if (command == "m") game.move();
		else if (command == "u") game.undo();
		else if (command == "q") done = true;
		else 
		{
			cout << "Invalid command: " << command << endl;
			cout << "Commands are s, m, u, or q." << endl << endl;
		}
	}
	return (0);
}
