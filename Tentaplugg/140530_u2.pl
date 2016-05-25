test(N, M):-
	member(N, [1, 2]),
	!,
	member(M, [3, 4]).

testo(N, M, K, J):-
	test(N, M),
	!,
	test(K, J).

picknumber([2|[]], 2).

picknumber([M|N], M):-
	M > 2,
	M2 is M-1,
	picknumber(N, M2).



subset([X|S], [X|Sub]):-
	subset(S, Sub).
subset([_|S], Sub):-
	subset(S, Sub).
subset([], []).

subsetSum(S, Sum, Sub):-
	subset(S, Sub),
	sumlist(Sub, Sum).

numSubsetSum(S, Sum, Num):-
	findall(Sub, (subsetSum(S, Sum, Sub)), Subs),
	length(Subs, Num).


