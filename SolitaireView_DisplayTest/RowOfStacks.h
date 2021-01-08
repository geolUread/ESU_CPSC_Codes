#pragma once
#ifndef ROWOFSTACKS_H
#define ROWOFSTACKS_H
#include "IListOfLists.h"
#include "CardList.h"
#include <vector>

class RowOfStacks : public IListOfLists {
private:
     std::vector<CardList*> row;
     int currIndex;
public:
     virtual int getListIndex(ICardList*);
     virtual int getCardIndex(int listIndex, ICard*);

     int getSize();
     ICardList* getFirstList();
     bool isFirst();
     ICardList* getLastList();
     bool isLast();
     ICardList* getNextList();
     ICardList* getPrevious();

     void add(CardList*);
     void add(CardList*, int);
     CardList* remove(int);
     void read(std::string);
     void write();
     RowOfStacks();
     ICardList* getListAtIndex(int);
};

#endif

