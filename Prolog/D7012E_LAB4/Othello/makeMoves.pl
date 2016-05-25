/*
Places bricks N times, each colot taking turn.
Returns new board after placing a brick.
If a color can't place brick, turns goes over to other player.
*/

makemoves(_, NewBoard, 0, [], NewBoard).

makemoves(Color, Board, N, [Move|Moves], NewBoard):-
	N > 0,
	legalmove(Color, Board, X, Y),
	makeMovesMain(Color, Board, (X, Y), Move, NextBoard),
	changeColor(Color, NextColor),
	N2 is N-1,
	makemoves(NextColor, NextBoard, N2, Moves, NewBoard).

makemoves(Color, Board, N, [(Color, n, n)|Moves], Board):-
	N > 0,
	\+ legalmove(Color, Board, X, Y),
	changeColor(Color, NextColor),
	N2 is N-1,
	makemoves(NextColor, Board, N2, Moves, NewBoard).

makeMovesMain(C, Board, (X,Y), (C, X, Y), NewBoard):-
	makemove(C, Board, X, Y, NewBoard).

%makeMovesMain(C, Board, [], (C, n, n), Board).