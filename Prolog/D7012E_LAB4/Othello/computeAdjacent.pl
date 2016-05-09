findRight(X1, X2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 + 1),
	X1Sum == ValueX2. 

findLeft(X1, X2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 - 1),
	X1Sum == ValueX2.

findUp(Y1, Y2):-
	Y1Sum is (Y1 - 1),
	Y1Sum == Y2.

findDown(Y1, Y2):-
	Y1Sum is (Y1 + 1),
	Y1Sum == Y2.

findLeftUp(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 - 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 - 1),
	Y1Sum == Y2.

findRightUp(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 + 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 - 1),
	Y1Sum == Y2.

findLeftDown(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 - 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 + 1),
	Y1Sum == Y2.

findRightDown(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 + 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 + 1),
	Y1Sum == Y2.
