%legalmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], X, Y).   
legalmove(Color, Board, X, Y):-
	isLegal(Color, Board, LegalMoves),
	member((Color, X, Y), LegalMoves).

isLegal(C, Board, Legal):-
	findMove(C, Board, Legal).
