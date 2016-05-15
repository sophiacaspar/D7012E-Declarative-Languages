:- [findMove, makeMove, makeMoves, bestMove, computeAdjacent, printBoard].
%Testboard (black should fail): [(black, d, 1), (white, d,2), (white, d,3), (black, d,4), (black, d,5), (black, d, 6)]
% Startboard: [(white,d,4),(black,e,4),(black,d,5),(white,e,5)]

/*
MAIN FILE (Consult this file to run program). 
*/


%%%%%%%%%%% LEGAL MOVE %%%%%%%%%%%%%%%%%%%%%%%%
/*
Checks if X-Y position for a color is legal by checking all 
possible moves which are added in a list, then uses member to check
if (Color, X, Y) is in that list.
*/
legalmove(Color, Board, X, Y):-
	isLegal(Color, Board, LegalMoves),
	member((Color, X, Y), LegalMoves).

% Finds all possible moves.
isLegal(C, Board, Legal):-
	findMove(C, Board, Legal).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
changeColor(white, black).
changeColor(black, white).

/*
Checks if input is valid.
*/
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

