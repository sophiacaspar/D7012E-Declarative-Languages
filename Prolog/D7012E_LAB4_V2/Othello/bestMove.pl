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


%boardOutcomes(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], All).
boardOutcomes(C, Board, MoveValue):-
	findall(((X,Y), NewBoard), makemove(C, Board, X,Y, NewBoard), AllPossible),
	evaluateBoards(C, AllPossible, MoveValue).
	%getHighest(C, MoveValue, High).

evaluateBoards(_, [], []).
evaluateBoards(C, [((X, Y), Board)|AllPossible], [(C, X, Y, Value)|MoveValue]):-
	valueof(C, Board, Value),
	evaluateBoards(C, AllPossible, MoveValue).


getHighest([], TempHigh, TempHigh).
getHighest([(C, X1, Y1, Value1)|AllPossible], (C, X2, Y2, Value2), High):-
	Value1 < Value2,
	getHighest(AllPossible, (C, X2, Y2, Value2), High)
	;
	getHighest(AllPossible, (C, X1, Y1, Value1), High).



