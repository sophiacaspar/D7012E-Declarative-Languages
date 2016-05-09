:- [computeAdjacent, checkLegalMove, printBoard].
settings:-
set_prolog_flag(toplevel_print_options, [quoted(true), portray(true), max_depth(1000), priority(699)]).

changeColor(white, black).
changeColor(black, white).

%legalmove(black, [(white,c,3),(white,d,3),(white,e,3),(white,e,4),(white,e,5),(white,d,5),(white,c,5),(white,c,4),(black, d,2),(black, f,4), (black,d,6), (black, b,4), (black,b,2), (black,f,2),(black,f,6),(black,b,6)], b, 3).
legalmove(Color, Board, X, Y):-
	checkCloseBricks(Color, Board, X, Y, StartBricks),!,
	startChain(Color, Board, StartBricks, Legal), 
	Legal \= [].

checkCloseBricks(_, [], _, _, []).

checkCloseBricks(Color, [(C1, X1, Y1)|Board], X, Y, [(X1, Y1, Trace)|StartBricks]):-
	Color \= C1,
	adjacent(X, X1, Y, Y1, Trace),
	checkCloseBricks(Color, Board, X, Y, StartBricks).

checkCloseBricks(Color, [(_, _, _)|Board], X, Y, StartBricks):-
	checkCloseBricks(Color, Board, X, Y, StartBricks).

startChain(_, _, [], []).	

startChain(C1, Board, [(X, Y, Dir)|_], NextBrick):-
	changeColor(C1, C2),
	checkMain((C2, X, Y), Board, NextBrick, Dir).

startChain(C1,Board, [_|StartBricks], Legal):-
	startChain(C1, Board, StartBricks, Legal).

%! right
adjacent(X1, X2, Y, Y, Trace):-
	findRight(X1, X2),
	Trace = right.

%! left
adjacent(X1, X2, Y, Y, Trace):-
	findLeft(X1, X2),
	Trace = left.

%! up
adjacent(X, X, Y1, Y2, Trace):-
	findUp(Y1, Y2),
	Trace = up.

%! down
adjacent(X, X, Y1, Y2, Trace):-
	findDown(Y1, Y2),
	Trace = down.

%! left-up
adjacent(X1, X2, Y1, Y2, Trace):-
	findLeftUp(X1, X2, Y1, Y2),
	Trace = leftUp.

%! right-up
adjacent(X1, X2, Y1, Y2, Trace):-
	findRightUp(X1, X2, Y1, Y2),
	Trace = rightUp.

%! left-down
adjacent(X1, X2, Y1, Y2, Trace):-
	findLeftDown(X1, X2, Y1, Y2),
	Trace = leftDown.

%! right-down
adjacent(X1, X2, Y1, Y2, Trace):-
	findRightDown(X1, X2, Y1, Y2),
	Trace = rightDown.
