:- [findMove, legalMove, printBoard].
changeColor(white, black).
changeColor(black, white).

validInput(Color, X, Y, Board):-
	char_type(X, alpha),
	integer(Y),
	char_code(X, ValueX),
	char_code(a, A),
	char_code(h, H),
	ValueX =< H, 
	ValueX >= A,
	Y =< 8,
	Y >= 1,
	validColor(Color), 
	Board \= [].

validColor(Color):-
	Color == black
	;
	Color == white.

%legalmove(Color, Board, X, Y).