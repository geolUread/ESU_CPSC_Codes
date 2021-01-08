#include"deck.h"

deck::deck(int x)
{
		 for (int i = 0; i < x; i++)
		 {
					int rank = i + 1;
					append(new card(rank));
		 }
}

//This function is not part of the scheme
void deck::viewDeck()
{
		 card* temp2 = removeLast();
		 cout << "Last card " << temp2->getRank() << endl;

		 card* temp = getNext();
		cout << "Next Card " << temp->getRank() << " " << endl;
		 
		 card* temp3 = getNext();
		 cout << "Next Card " << temp3->getRank() << " " << endl;

}
