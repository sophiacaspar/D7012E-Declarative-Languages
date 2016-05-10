:- [makeMove].

makemoves(Color, Board, N, Moves, NewBoard):-
	N > 0.


%findStartMove(black, [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)], Startmove).
findColorList(C, [(C1, X, Y)|Board], [(C1, X, Y)|ColorList]):-
	C == C1,
	findColorList(C, Board, ColorList),!.

findColorList(C, [(C1, X, Y)|Board], ColorList):-
	findColorList(C, Board, ColorList).

findColorList(_, [], []).

findClose(Board, [(C, X, Y)|ColorList], [StartBricks|All]):-
	checkCloseBricks(C, Board, X, Y, StartBricks),!,
	findClose(Board, ColorList, All).

findClose(_, [], []).

%findMove(black, [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)], Move).
findMove(C, Board, Move):-
	findColorList(C, Board, ColorList),
	findClose(Board, ColorList, All),
	flatten(All, Move), !.


checkMove((C, X1, Y1), Board, [(X1, Y1, Dir)|Move], left):-
	checkChain((C, X1, Y1), Board, (C1, X2, Y2), Dir),
	C == C1,
	checkMain((C1, X2, Y2), Board, NextBrick, Dir).

