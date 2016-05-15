%findbestmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], 6, X, Y).
% Return a move which could generate highest board after N moves.
findbestmove(Color, Board, N, X,Y):-
	findall((Moves, NewBoard), makemoves(Color, Board, N, Moves, NewBoard), AllPossible),
	evaluateBoard(Color, AllPossible, MoveValue),
	getHighest(MoveValue, start, (_, X, Y, _)),!.

% Returns total value of a borad for a specific color
valueof(Color, Board, Value):-
	findColorList(Color, Board, ColorList),!,
	calcValue(ColorList, TempValue),
	sumlist(TempValue, Value),!.

% Calculates value of each brick in board with specific color
calcValue([], []).
calcValue([(_, X, Y)|ColorList], [Value|CurValue]):-
	getValue(X, Y, Value),
	calcValue(ColorList, CurValue).

% Returns a value for a specific brick
getValue(X, Y, Value):-
	isEdge(X, Y, _),
	isCorner(X, Y, Value),!
	;
	isEdge(X, Y, Value),!
	;
	Value = 1,!.

% Defines edges and their value
isEdge(a, _, 5).
isEdge(h, _, 5).
isEdge(_, 1, 5).
isEdge(_, 8, 5).

% Defines corners and their value
isCorner(a, 1, 10).
isCorner(a, 8, 10).
isCorner(h, 1, 10).
isCorner(h, 8, 10).

% Evaluetes each possible board-value after every possible brick is placed
evaluateBoard(C, [], []).
evaluateBoard(C, [([(C, X, Y)|Moves], NewBoard)|AllPossible], [(C, X, Y, Value)|MoveValue]):-
	valueof(C, NewBoard, Value),
	evaluateBoard(C, AllPossible, MoveValue).

% Returns the brick that has the highest newboard as outcome
getHighest([], TempHigh, TempHigh).
getHighest([(C, X1, Y1, Value1)|AllPossible], (C, X2, Y2, Value2), Highest):-
	Value1 =< Value2,
	getHighest(AllPossible, (C, X2, Y2, Value2), Highest)
	;
	getHighest(AllPossible, (C, X1, Y1, Value1), Highest).
getHighest([(C, X1, Y1, Value1)|AllPossible], start, Highest):-
	getHighest(AllPossible, (C, X1, Y1, Value1), Highest).



