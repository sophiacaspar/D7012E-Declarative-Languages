:- [makeMoves].

findbestmove(Color, Board, N, X, Y):-
	findMove(Color, Board, OKMoves).


valueof(Color, Board, Value):-
	findColorList(Color, Board, ColorList),!,
	calcValue(ColorList, TempValue),
	sumlist(TempValue, Value),!.

calcValue([], []).

calcValue([(_, X, Y)|ColorList], [Value|CurValue]):-
	getValue(X, Y, Value),
	calcValue(ColorList, CurValue).

getValue(X, Y, Value):-
	isEdge(X, Y, Value),
	isCorner(X, Y, Value)
	;
	isEdge(X, Y, Value)
	;
	Value = 1.

isEdge(a, _, 2).
isEdge(h, _, 2).
isEdge(_, 1, 2).
isEdge(_, 8, 2).

isCorner(a, 1, 3).
isCorner(a, 8, 3).
isCorner(h, 1, 3).
isCorner(h, 8, 3).


testMove(C, Board, N, AllResults):-
	findall((Moves, NewBoard), makemoves(C, Board, N, Moves, NewBoard), AllResults).

