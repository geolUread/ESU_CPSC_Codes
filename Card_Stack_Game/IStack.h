#if !defined ISTACK_H
#define ISTACK_H
//This is an interface class
#include "card.h"
class IStack
{
public:
	virtual void push(card*) = 0;
	virtual card* pop() = 0;
	virtual bool isEmpty() = 0;
};
#endif