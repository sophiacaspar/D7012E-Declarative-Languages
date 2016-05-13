makemoves(_, NewBoard, 0, [], NewBoard).

makemoves(Color, Board, N, [Move|Moves], NewBoard):-
	N > 0,
	legalmove(Color, Board, X, Y),
	makeMovesMain(Color, Board, (X, Y), Move, NextBoard),
	changeColor(Color, NextColor),
	N2 is N-1,
	makemoves(NextColor, NextBoard, N2, Moves, NewBoard).

makeMovesMain(C, Board, (X,Y), (C, X, Y), NewBoard):-
	makemove(C, Board, X, Y, NewBoard).

makeMovesMain(C, Board, [], (C, n, n), Board).