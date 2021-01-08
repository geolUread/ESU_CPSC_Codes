#pragma once
#if !defined ICARDCOLLECTION_H
#define ICARDCOLLECTION_H


//This is an interface class 
class ICard;
class ICardList;

class ICardCollection
{
public:
	//This function returns the size of the cardObject.
	virtual int getSize()= 0;

};
#endif
