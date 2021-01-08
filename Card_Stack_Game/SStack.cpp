#include"SStack.h"

void SStack::push(card* x)
{ 
		 append(x);
}

card* SStack::pop()
{
		 return removeLast();
}

bool SStack::isEmpty()
{
	return cardlist::isEmpty();
}


