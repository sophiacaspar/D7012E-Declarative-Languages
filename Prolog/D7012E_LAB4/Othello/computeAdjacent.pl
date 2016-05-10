
findRight(X1, X2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 + 1),
	X1Sum == ValueX2.
getRight(X1, X2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 + 1),
	char_code(X2, X1Sum).
	

findLeft(X1, X2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 - 1),
	X1Sum == ValueX2.
getLeft(X1, X2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 - 1),
	char_code(X2, X1Sum).


findUp(Y1, Y2):-
	Y1Sum is (Y1 - 1),
	Y1Sum == Y2.
getUp(Y1, Y2):-
	Y2 is (Y1 - 1).


findDown(Y1, Y2):-
	Y1Sum is (Y1 + 1),
	Y1Sum == Y2.
getDown(Y1, Y2):-
	Y2 is (Y1 + 1).


findLeftUp(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 - 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 - 1),
	Y1Sum == Y2.
getLeftUp(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 - 1),
	char_code(X2, X1Sum),
	Y2 is (Y1- 1).


findRightUp(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 + 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 - 1),
	Y1Sum == Y2.
getRightUp(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 + 1),
	char_code(X2, X1Sum),
	Y2 is (Y1- 1).


findLeftDown(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 - 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 + 1),
	Y1Sum == Y2.
getLeftDown(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 - 1),
	char_code(X2, X1Sum),
	Y2 is (Y1 + 1).


findRightDown(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	char_code(X2, ValueX2),
	X1Sum is (ValueX1 + 1),
	X1Sum == ValueX2,
	Y1Sum is (Y1 + 1),
	Y1Sum == Y2.
getRightDown(X1, X2, Y1, Y2):-
	char_code(X1, ValueX1),
	X1Sum is (ValueX1 + 1),
	char_code(X2, X1Sum),
	Y2 is (Y1 + 1).
