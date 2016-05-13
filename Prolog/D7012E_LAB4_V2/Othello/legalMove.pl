legalmove(Color, Board, X, Y):-
	%validInput(Color, X, Y, Board),
	isLegal(Color, Board, LegalMoves),
	member((Color, X, Y), LegalMoves).

isLegal(C, Board, Legal):-
	findMove(C, Board, Legal).
	%findall(Legal,findMove(C, Board, Legal), All),
	%flatten(All, AllLegal).
	%removeDuplicates(AllLegal, LegalMoves).
	%changeColor(C, C1),
	%findMove(white, Board, Legal2),
	%flatten([Legal1|Legal2], LegalMoves).
