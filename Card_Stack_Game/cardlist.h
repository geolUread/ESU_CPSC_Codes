#pragma once
#if !defined CARDLIST_H
#define CARDLIST_H

#include"card.h"
#include"IReadCardList.h"
#define TOTAL 52

class cardlist : public IReadCardList
{
private:
		 int numCards;
		 card* arrayCards[TOTAL];
		 int current_index;
public:
		 cardlist();
		 card* getFirst();
		 card* getNext();
		 void append(card*);
		 card* removeLast();
		 bool isEmpty();
};
#endif