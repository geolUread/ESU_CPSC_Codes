//Sean Team A Helped with this stub

#include "RowOfStacks.h"
int RowOfStacks::getSize() { return row.size(); }

ICardList* RowOfStacks::getFirstList()
{
     currIndex = 0;
     ICardList* temp = (ICardList*)((CardList*)row.front());
     return temp;
}

bool RowOfStacks::isFirst()
{
     return currIndex == 0;
}

ICardList* RowOfStacks::getLastList()
{
     ICardList* temp = (ICardList*)row.back();
     row.pop_back();
     currIndex = row.size() - 1;
     return temp;
}

int RowOfStacks::getListIndex(ICardList* t)
{
     int ans = -1;
     for (int i = 0; i < getSize(); i++) {
          if (getListAtIndex(i) == t) {
               ans = i;
          }
     }
     return ans;
}

int RowOfStacks::getCardIndex(int listIndex, ICard*)
{
     return 0;
}

bool RowOfStacks::isLast()
{
     return (currIndex == getSize() - 1);
}

ICardList* RowOfStacks::getNextList()
{
     ICardList* temp = (ICardList*)row.at(currIndex);
     currIndex++;
     return temp;
}

ICardList* RowOfStacks::getPrevious()
{
     ICardList* temp = (ICardList*)row.at(currIndex);
     currIndex--;
     return temp;
}

ICardList* RowOfStacks::getListAtIndex(int i)
{
     ICardList* temp = row.at(i);
     return temp;
}

void RowOfStacks::add(CardList* s) { row.push_back(s); }

void RowOfStacks::add(CardList* s, int i) {}

CardList* RowOfStacks::remove(int i)
{
     CardList* temp = row.at(i);
     row.erase(row.begin() + i);
     return temp;
}

void RowOfStacks::write()
{
}

void RowOfStacks::read(std::string filename)
{
}
RowOfStacks::RowOfStacks() { currIndex = 0; }