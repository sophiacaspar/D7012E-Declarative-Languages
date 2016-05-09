%! [Fox, Goat, Beans, Boat]

%! Possible moving directions
%! Either from east to west or from west to east
move(east, west).
move(west, east).

%! Defines what happens when Fox crosses
%! Input: Fox and boat on the same side, fox and boat on the other side
%! Output: Fox moved to which side
cross([X, G, B, X], NewState, Moved):-
	move(X,Y),  %! move from side X to side Y
	not(invalid([Y, G, B, Y])), %! Checks if new position for fox and boat is ok (false if not)
	output(Y, fox, Moved), %! Creates an output with who went where
	NewState = [Y, G, B, Y]. %! Sets a new position (state) for the fox

%! Defines what happens when Goat crosses
%! Input: Goat and boat on the same side, goat and boat on the other side
%! Output: Goat moved to which side
cross([F, X, B, X], NewState, Moved):-
	move(X,Y),
	not(invalid([F, Y, B, Y])),
	output(Y, goat, Moved),
	NewState = [F, Y, B, Y].

%! Defines what happens when Beans crosses
%! Input: Beans and boat on the same side, beans and boat on the other side
%! Output: Beans moved to which side
cross([F, G, X, X], NewState, Moved):-
	move(X,Y),
	not(invalid([F, G, Y, Y])),
	output(Y, beans, Moved),
	NewState = [F, G, Y, Y].

%! Defines what happens when Boat crosses
%! Input: Boat on one side, boat on the other side
%! Output: Boat moved to which side
cross([F, G, B, X], NewState, Moved):-
	move(X,Y),
	not(invalid([F, G, B, Y])),
	output(Y, boat, Moved),
	NewState = [F, G, B, Y].

%! Defines which moves are not valid. 
%! Fox and goat can not be on same side.
%! Goat and beans can not be on same side.
invalid([X, X, _, Y]):- 
	X \== Y.
invalid([_, X, X, Y]):- 
	X \== Y.

%! Creates tripplets with what happens after a move. 
%! Who moved from where to where
output(Change, Who, Moved):-
	move(From, Change),
	Moved = (Who, From, Change).

%! Base case
%! When fox, goat, beans and boat are on the same side as destination side,
%! Program is done, no matter what N is.
%! Returns an empty list, where all tripplets are placed in.
solvefgb([Dest, Dest, Dest, Dest], Dest, _, []).

%! Clause to run the whole program 
%! Input: A current state for all for (list), a destination (east or west),
%! 	A value N (runs n times)
%! Output: a list where all moved-tripplets are added in beginning, trace is a list which should reach base case.
solvefgb(State,Dest,N, [Moved|Trace]) :-
	N > 0, %! runs as long as N is greater than 0
	cross(State, NewState, Moved), %! crossing
	solvefgb(NewState, Dest, N-1, Trace). %! recursive call with the new state after crossing

