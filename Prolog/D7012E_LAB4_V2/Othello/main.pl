:- [findMove, legalMove, printBoard, makeMove, makeMoves, bestMove].
changeColor(white, black).
changeColor(black, white).

validColor(Color):-
	Color == black
	;
	Color == white.


validInput(C, X ,Y, Board):-
	validColor(C),
	Board \== [],
	nonvar(X),
	char_type(X, alpha),
	integer(Y),
	char_code(X,X1),
	X1 < 105,
	X1 > 96,
	Y > 0,
	Y < 9 
	;
	not(nonvar(X)),
	integer(Y),
	Y > 0,
	Y < 9, 
	Board \== []
	;
	not(nonvar(X)),
	not(nonvar(Y)),
	Board \== []
	;
	not(nonvar(Y)),
	char_type(X, alpha),
	char_code(X,X1),
	X1 < 105,
	X1 > 96,
	Board \== [].

