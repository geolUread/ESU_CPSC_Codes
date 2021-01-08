#if !defined IREADCARDLIST_H
#define IREADCARDLIST_H
//This is an interface class
#include "card.h"
class IReadCardList
{
public:
	virtual card* getFirst() = 0;
	virtual card* getNext() = 0;
};
#endif

