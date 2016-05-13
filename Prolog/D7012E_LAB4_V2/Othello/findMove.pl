:- [computeAdjacent].

%findMove(black, [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)], Move).
findMove(C, Board, OKMoves):-
	%findColorList(C, Board, ColorList),
	%findClose(Board, ColorList, All),
	findClose(Board, Board, All),
	flatten(All, CheckMove),
	changeColor(C, C1),
	checkMoveMain(C1, Board, CheckMove, Move),
	removeDuplicates(Move, OKMoves).

%findStartMove(black, [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)], Startmove).
findColorList(C, [(C1, X, Y)|Board], [(C1, X, Y)|ColorList]):-
	C == C1,
	findColorList(C, Board, ColorList).

findColorList(C, [_|Board], ColorList):-
	findColorList(C, Board, ColorList).

findColorList(_, [], []).

findClose(_, [], []).
findClose(Board, [(C, X, Y)|ColorList], [StartBricks|All]):-
	checkCloseBricks(C, Board, X, Y, StartBricks),!,
	findClose(Board, ColorList, All).

checkCloseBricks(_, [], _, _, []).

checkCloseBricks(Color, [(C1, X1, Y1)|Board], X, Y, [(X1, Y1, Trace)|StartBricks]):-
	Color \= C1,
	adjacent(X, X1, Y, Y1, Trace),
	checkCloseBricks(Color, Board, X, Y, StartBricks).

checkCloseBricks(Color, [(_, _, _)|Board], X, Y, StartBricks):-
	checkCloseBricks(Color, Board, X, Y, StartBricks).


checkMoveMain(_, _, [], []).

checkMoveMain(C, Board, [(X, Y, Dir)|CheckMove], [OKMove|Move]):-
	checkMove((C, X, Y), Board, OKMove, Dir),
	checkMoveMain(C, Board, CheckMove, Move),!.

checkMoveMain(C, Board, [_|CheckMove], Move):-
	checkMoveMain(C, Board, CheckMove, Move).

%left
checkMove((C, X1, Y1), Board, OKMove, left):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getLeft(X1, X2),
	checkMove((C, X2, Y1), Board, OKMove, left).

%right
checkMove((C, X1, Y1), Board, OKMove, right):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getRight(X1, X2),
	checkMove((C, X2, Y1), Board, OKMove, right).

%up
checkMove((C, X1, Y1), Board, OKMove, up):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getUp(Y1, Y2),
	checkMove((C, X1, Y2), Board, OKMove, up).

%down
checkMove((C, X1, Y1), Board, OKMove, down):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getDown(Y1, Y2),
	checkMove((C, X1, Y2), Board, OKMove, down).

%leftUp
checkMove((C, X1, Y1), Board, OKMove, leftUp):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getLeftUp(X1, X2, Y1, Y2),
	checkMove((C, X2, Y2), Board, OKMove, leftUp).

%rightUp
checkMove((C, X1, Y1), Board, OKMove, rightUp):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getRightUp(X1, X2, Y1, Y2),
	checkMove((C, X2, Y2), Board, OKMove, rightUp).

%leftDown
checkMove((C, X1, Y1), Board, OKMove, leftDown):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getLeftDown(X1, X2, Y1, Y2),
	checkMove((C, X2, Y2), Board, OKMove, leftDown).

%rightDown
checkMove((C, X1, Y1), Board, OKMove, rightDown):-
	validInput(C, X1, Y1, Board),
	member((C1, X1, Y1), Board),
	C == C1,
	getRightDown(X1, X2, Y1, Y2),
	checkMove((C, X2, Y2), Board, OKMove, rightDown).

% If we find an empty brick
checkMove((C, X1, Y1), Board, (C1, X1, Y1), _):-
	validInput(C, X1, Y1, Board),
	changeColor(C, C1),
	\+member((_, X1, Y1), Board).

removeDuplicates([], []).
removeDuplicates([H|T], [H|T1]) :- subtract(T, [H], T2), removeDuplicates(T2, T1).

