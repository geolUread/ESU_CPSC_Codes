#if !defined SSTACK_H
#define SSTACK_H

#include "cardlist.h"
#include "IStack.h"

#include<iostream>
using namespace std;

class SStack : public cardlist, public IStack
{
public:
		 void push(card*);
		 card* pop();
		 bool isEmpty();
};

#endif