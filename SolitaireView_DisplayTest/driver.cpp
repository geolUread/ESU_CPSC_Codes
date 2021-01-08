#define WIN32_LEAN_AND_MEAN             // Exclude rarely-used stuff from Windows headers
#include <windows.h>
#include <stdlib.h>
#include <malloc.h>
#include <memory.h>
#include <tchar.h>
#include <time.h>
#include <stdio.h>
#include <string>

//SOFTWARE ENGINEERING INCLUDE FILES
#include "CardAreaView.h"
#include "CardView.h"
#include "ICardList.h"
#include "CardList.h"
#include "IListOfLists.h"
#include "ICardCollection.h"
#include "SolitaireGameView.h"

#define ID_2DSLIDER 1
#define ID_QUIT 2

#define MAX_LOADSTRING 100
#define SIDEBAR_WIDTH 150
#define SIDEBAR_LENGTH 150
#define NUM_SUBWINDOWS 2


HDC         MainHdc;
HWND		MainHwnd;
wchar_t MainWindowText[MAX_LOADSTRING];

//all windows have to have a callback function, it's invoked when ANYTHING happens to the window.
//what you do with the event, or message is your business.  We're usually concerned with mouse clicks, creation, and painting

int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR szCmdLine, int iCmdShow);

LRESULT CALLBACK MainWndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
LRESULT CALLBACK SubWndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
;
const wchar_t* szSubName = L"card area";

//SOFTWARE ENGINEER -- CardAreaView subwindows created here
CardAreaView* cardAreaView;
CardAreaView* cardAreaView1;
CardAreaView* cardAreaView2;
CardAreaView* cardAreaView3;
CardAreaView* cardAreaView4;
CardAreaView* cardAreaView5;

std::string* views;
//SUBWINDOWS ARE CREATED HERE
HWND hWnd_subwindow1;
HWND hWnd_subwindow2;
HWND hWnd_subwindow3;
HWND hWnd_subwindow4;
HWND hWnd_subwindow5;

int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
		 PSTR szCmdLine, int iCmdShow)
{
		 MSG msg;

		 //SOFTWARE ENGINEERING -- Creating a CardList Object
		 CardList* cardList1 = new CardList();			//vertical stack

		 CardList* cardList2 = new CardList();			//deck

		 /* Lists for tableau*/
		 CardList* cardList3 = new CardList();
		 Card* threeS = new Card(2, Spades);
		 threeS->flip();
		 cardList3->addToBeginning(threeS);

		 CardList* cardList4 = new CardList();
		 Card* kingH = new Card(12, Hearts);
		 kingH->flip();
		 cardList4->addToBeginning(kingH);
		 cardList4->addToBeginning(new Card(4, Diamonds));

		 CardList* cardList5 = new CardList();
		 Card* twoC = new Card(1, Clubs);
		 twoC->flip();
		 cardList5->addToBeginning(twoC);
		 cardList5->addToBeginning(new Card(10, Spades));
		 cardList5->addToBeginning(new Card(8, Diamonds));

		 CardList* cardList6 = new CardList();
		 Card* tC = new Card(2, Clubs);
		 tC->flip();
		 cardList6->addToBeginning(tC);
		 cardList6->addToBeginning(new Card(10, Spades));
		 cardList6->addToBeginning(new Card(8, Diamonds));
		 cardList6->addToBeginning(new Card(3, Diamonds));

		 CardList* cardList7 = new CardList();
		 Card* wC = new Card(3, Clubs);
		 wC->flip();
		 cardList7->addToBeginning(wC);
		 cardList7->addToBeginning(new Card(10, Spades));
		 cardList7->addToBeginning(new Card(9, Diamonds));
		 cardList7->addToBeginning(new Card(6, Diamonds));
		 cardList7->addToBeginning(new Card(11, Spades));

		 CardList* cardList8 = new CardList();
		 Card* C = new Card(4, Clubs);
		 C->flip();
		 cardList8->addToBeginning(C);
		 cardList8->addToBeginning(new Card(10, Spades));
		 cardList8->addToBeginning(new Card(8, Hearts));
		 cardList8->addToBeginning(new Card(8, Diamonds));
		 cardList8->addToBeginning(new Card(10, Hearts));
		 cardList8->addToBeginning(new Card(5, Diamonds));

		 CardList* cardList9 = new CardList();
		 Card* oC = new Card(5, Clubs);
		 oC->flip();
		 cardList9->addToBeginning(oC);
		 cardList9->addToBeginning(new Card(10, Spades));
		 cardList9->addToBeginning(new Card(8, Diamonds));
		 cardList9->addToBeginning(new Card(8, Diamonds));
		 cardList9->addToBeginning(new Card(8, Diamonds));
		 cardList9->addToBeginning(new Card(8, Diamonds));
		 cardList9->addToBeginning(new Card(8, Diamonds));

		 CardList* cardList10 = new CardList();
		 Card* twC = new Card(1, Clubs);
		 Card* threeC = new Card(2, Clubs);
		 Card* fourC = new Card(3, Clubs);
		 Card* fiveC = new Card(4, Clubs);
		 twC->flip();
		 threeC->flip();
		 fourC->flip();
		 fiveC->flip();
		 cardList10->addToBeginning(twC);
		 cardList10->addToBeginning(threeC);
		 cardList10->addToBeginning(fourC);
		 cardList10->addToBeginning(fiveC);

		 RowOfStacks* rows = new RowOfStacks();
		 rows->add(cardList3);
		 rows->add(cardList4);
		 rows->add(cardList5);
		 rows->add(cardList6);
		 rows->add(cardList7);
		 rows->add(cardList8);
		 rows->add(cardList9);

		 RowOfStacks* foun = new RowOfStacks();
		 foun->add(cardList3);
		 foun->add(cardList4);
		 foun->add(cardList5);
		 foun->add(cardList6);


		 //SOFTWARE ENGINEERING -- Adding cards to the cardlist
		 cardList1->addToBeginning(new Card(0, Spades));
		 cardList1->addToBeginning(new Card(1, Spades));
		 cardList1->addToBeginning(new Card(2, Spades));

		 Card* one = new Card(1, Diamonds);
		 Card* two = new Card(10, Diamonds);
		 one->flip();
		 two->flip();
		 cardList2->addToBeginning(one);
		 cardList2->addToBeginning(two);

		 //SOFTWARE ENGINEERING -- Creating Subwindow sizes
		 int areaWidth = 72;
		 int areaHeight = 100;

		 //Created card area view
		 //cardAreaView1 = new CardAreaView(0, 0, areaWidth, areaHeight, cardList1); // vertical stack
		 //cardAreaView2 = new CardAreaView(0, 0, 72, 100, cardList2);
		 //cardAreaView3 = new CardAreaView(0, 0, 400, 100, foun);

		 //cardAreaView4 = new CardAreaView(0, 0, 600, 400, rows);
		 //cardAreaView5 = new CardAreaView(0, 0, 600, 100, cardList10);

		 IGameView* gameView = new SolitaireGameView(cardList1, cardList2, foun, rows);
		 cardAreaView1 = gameView->getCardAreaView(1);
		 cardAreaView2 = gameView->getCardAreaView(2);
		 cardAreaView3 = gameView->getCardAreaView(3);
		 cardAreaView4 = gameView->getCardAreaView(4);

		 // set characteristics of MainWndClass and SubWndClass
		 const wchar_t* szAppName = L"Dialog";
		 WNDCLASS MainWndClass, SubWndClass;

		 MainWndClass.style = CS_HREDRAW | CS_VREDRAW;
		 MainWndClass.lpfnWndProc = MainWndProc; // name of the callback for main window
		 MainWndClass.cbClsExtra = 0;  // No extra class bytes
		 MainWndClass.cbWndExtra = 0;  // No extra window bytes
		 MainWndClass.hInstance = hInstance;
		 MainWndClass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
		 MainWndClass.hCursor = LoadCursor(NULL, IDC_ARROW);
		 MainWndClass.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
		 MainWndClass.lpszMenuName = NULL;
		 MainWndClass.lpszClassName = szAppName; // name of class that handles main window events
		 RegisterClass(&MainWndClass);

		 SubWndClass.style = CS_HREDRAW | CS_VREDRAW;
		 SubWndClass.lpfnWndProc = SubWndProc; // name of the callback for subwindows
		 SubWndClass.cbClsExtra = 0;  // No extra class bytes
		 SubWndClass.cbWndExtra = 12;  // extra bytes to store pointer
		 SubWndClass.hInstance = hInstance;
		 SubWndClass.hIcon = NULL;
		 SubWndClass.hCursor = LoadCursor(NULL, IDC_ARROW);
		 SubWndClass.hbrBackground = NULL;
		 SubWndClass.lpszMenuName = NULL;
		 SubWndClass.lpszClassName = szSubName; // name of class that handles subwindow events
		 RegisterClass(&SubWndClass);

		 // create the main window and display it
		 HWND hWnd;
		 hWnd = CreateWindow(szAppName,           // name of class that handles main window events
					L".... PROGRAM ", // window caption
					WS_OVERLAPPEDWINDOW, // window style
					CW_USEDEFAULT,       // init x pos
					CW_USEDEFAULT,       // init y pos
					1000,                 // init x size
					730,                 // init y size
					NULL,                // parent window
					NULL,                // window menu
					hInstance,           // program instance
					NULL);               // create params.
		 MainHwnd = hWnd;  /* store away the handle for global use */

		 ShowWindow(hWnd, iCmdShow); // display it
		 UpdateWindow(hWnd);

		 // loop "forever"
		 while (GetMessage(&msg, NULL, 0, 0)) {
					TranslateMessage(&msg); // translate key codes
					DispatchMessage(&msg);  // call window procedure
		 }

		 return (int)msg.wParam;
}

// the callback for the main window (invoked via DispatchMessage())
LRESULT CALLBACK MainWndProc(HWND hWnd, // handle to the window
		 UINT msg, WPARAM wParam, LPARAM lParam) // describes the event
{

		 //-------------------------------------------------------------------------
		 HWND* buttonarray;
		 //--------------------------------------------------------------------------

		 LRESULT		retVal = 0;
		 static int  cxChar, cyChar;
		 RECT        rect;
		 HDC         hdc;
		 PAINTSTRUCT ps;
		 HPEN        hOldPen;
		 HBRUSH      hOldBrush;

		 //-----------------------------------------------------------------------------
		 buttonarray = new HWND[2];
		 int			button_x = 0;
		 const wchar_t* labels[2];
		 labels[0] = L"Quit";
		 labels[1] = L"Do Nothing";
		 //------------------------------------------------------------------------------

		 switch (msg)
		 {
		 case WM_CREATE:  // for initialization that happens when window is created
			 /*this runs only once, as soon as the main window is created.
			 use this opportunity to create the children */

					MainHdc = BeginPaint(hWnd, &ps);
					EndPaint(hWnd, &ps);
					cxChar = LOWORD(GetDialogBaseUnits());
					cyChar = HIWORD(GetDialogBaseUnits());

					GetClientRect(hWnd, &rect);
					//Create subwindows here to display image===============================================================================
							// create the first subwindow

					hWnd_subwindow1 = CreateWindow(szSubName,   // name of class that handles subwindow events
							 NULL, // window caption
							 WS_CHILD | WS_VISIBLE, // window style
							 cardAreaView1->getPositionX(),       // init x pos
							 cardAreaView1->getPositionY(),       // init y pos
						cardAreaView1->getExtentX(),       // init x size
						cardAreaView1->getExtentY(),                 // init y size
							 hWnd,                // parent window
							 (HMENU)ID_2DSLIDER,                // window menu
							 (HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),           // program instance
							 NULL);               // create params.
					SetWindowLong(hWnd_subwindow1, DWL_USER, (long)(cardAreaView1)); // associate a view object with this window


					//// create the second subwindow
					hWnd_subwindow2 = CreateWindow(szSubName,    // name of class that handles subwindow events
							 NULL, // window caption
							 WS_CHILD | WS_VISIBLE, // window style
						cardAreaView2->getPositionX(),       // init x pos
						cardAreaView2->getPositionY(),       // init y pos	
						cardAreaView2->getExtentX(),       // init x size
						cardAreaView2->getExtentY(),                 // init y size

							 hWnd,                // parent window
							 (HMENU)ID_2DSLIDER,                // window menu
							 (HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),           // program instance
							 NULL);               // create params.
					SetWindowLong(hWnd_subwindow2, DWL_USER, (long)(cardAreaView2)); // associate a view object with this window

					hWnd_subwindow3 = CreateWindow(szSubName,    // name of class that handles subwindow events
							 NULL, // window caption
							 WS_CHILD | WS_VISIBLE, // window style
		

						cardAreaView3->getPositionX(),       // init x pos
						cardAreaView3->getPositionY(),       // init y pos
						cardAreaView3->getExtentX(),       // init x size
							 cardAreaView3->getExtentY(),                 // init y size
							 hWnd,                // parent window
							 (HMENU)ID_2DSLIDER,                // window menu
							 (HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),           // program instance
							 NULL);               // create params.
					SetWindowLong(hWnd_subwindow3, DWL_USER, (long)(cardAreaView3));

					hWnd_subwindow4 = CreateWindow(szSubName,    // name of class that handles subwindow events
							 NULL, // window caption
							 WS_CHILD | WS_VISIBLE, // window style

						cardAreaView4->getPositionX(),       // init x pos
						cardAreaView4->getPositionY(),       // init y pos
						cardAreaView4->getExtentX(),       // init x size
						cardAreaView4->getExtentY(),                 // init y size

							 hWnd,                // parent window
							 (HMENU)ID_2DSLIDER,                // window menu
							 (HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE),           // program instance
							 NULL);               // create params.
					SetWindowLong(hWnd_subwindow4, DWL_USER, (long)(cardAreaView4));

					//============================================================================================================

		 case WM_PAINT:		// paint event-- window should display itself

					hdc = BeginPaint(hWnd, &ps);   //read up ob brushes and such.  it's basically the color you paint with
					GetClientRect(hWnd, &rect);

					hOldPen = (HPEN)SelectObject(hdc, GetStockObject(BLACK_PEN));
					hOldBrush = (HBRUSH)SelectObject(hdc, GetStockObject(WHITE_BRUSH));

					Rectangle(hdc, 0, 0, rect.right, rect.bottom);
					TextOut(hdc, 25, 450, MainWindowText, (int)wcslen(MainWindowText));  // display whatever is in MainWindowText

					SelectObject(hdc, hOldBrush);  // put the brush and pen back to the color they were before you used them
					SelectObject(hdc, hOldPen);

					EndPaint(hWnd, &ps);
					break;


		 case WM_COMMAND: // an event tied to a GUI component

					if (HIWORD(wParam) == BN_CLICKED) { // a GUI button was clicked

							 swprintf_s(MainWindowText, MAX_LOADSTRING, L"Clicked button %s", labels[LOWORD(wParam)]);

							 GetClientRect(MainHwnd, &rect);
							 InvalidateRect(MainHwnd, &rect, FALSE);

							 if (labels[LOWORD(wParam)] == L"Quit") { // Quit button was clicked
										PostQuitMessage(0); // terminate the application
							 }
							 else if (labels[LOWORD(wParam)] == L"Do Nothing") // Do Nothing button was clicked
							 {
										// in the future, do something to the application when this button is clicked!
							 }
					}
					break;

		 case WM_DESTROY: // to terminate the application
					PostQuitMessage(0);
					break;

		 default:
					retVal = DefWindowProc(hWnd, msg, wParam, lParam);
		 }

		 return retVal;
}

// the callback for any of the subwindows (invoked via DipatchMessage())
LRESULT CALLBACK SubWndProc(HWND hWnd, // handle to the window
		 UINT msg, WPARAM wParam, LPARAM lParam) // describes the event
{
		 LRESULT		retVal = 0;
		 HDC         hdc;
		 PAINTSTRUCT ps;
		 RECT Rect;
		 RECT rect;

		 GetClientRect(hWnd, &Rect);

		 static int  cxChar, cyChar;
		 CardAreaView* cardAreaView = (CardAreaView*)GetWindowLong(hWnd, DWL_USER);
		 switch (msg)
		 {
		 case WM_CREATE: // for initialization that happens when the window is created
					cxChar = LOWORD(GetDialogBaseUnits());
					cyChar = HIWORD(GetDialogBaseUnits());
					break;

		 case WM_PAINT: // paint event-- window should display itself
					hdc = BeginPaint(hWnd, &ps);

					//Display using CardView----------------------------------------------------------------------
					//The x and y values shows were to position the card in the subwindow 
					//cardAreaView = (CardAreaView*)GetWindowLong(hWnd, DWL_USER);
					cardAreaView->cardViewDisplay(&hdc);
					//------------------------------------------------------------------------------------------------


					EndPaint(hWnd, &ps);
					break;

		 case WM_LBUTTONUP: // left mouse button released (up)
		 {
					GetClientRect(MainHwnd, &rect);
					CardIdentity* tempIdent = new CardIdentity;
					tempIdent = cardAreaView->click(LOWORD(lParam), HIWORD(lParam));
					swprintf_s(MainWindowText, MAX_LOADSTRING, L"Clicked in subwindow; cursor position (%d,%d); index: (%d)", LOWORD(lParam), HIWORD(lParam), tempIdent->cardIndex);
					InvalidateRect(MainHwnd, &rect, FALSE);

					cardAreaView = (CardAreaView*)GetWindowLong(hWnd, DWL_USER); // get the associated view

					GetClientRect(MainHwnd, &rect);
					InvalidateRect(MainHwnd, &rect, FALSE);
		 }
		 break;

		 case WM_ERASEBKGND:
					retVal = (LONG)TRUE;
					break;

		 case WM_DESTROY: // to terminate the application
					PostQuitMessage(0);
					break;

		 default:
					retVal = DefWindowProc(hWnd, msg, wParam, lParam);
		 }
		 //delete i;
		 return retVal;
}
