-module(toto).

%% API
-export([add/1, add/2, divide/2]).


add([Head | []]) -> Head;
add([Head | Tail]) -> 
	%% add(Head, add(Tail)).
	add0([Head | Tail], 0).

add0([], Acc) -> Acc;
add0([Head | Tail], Acc) -> add0(Tail, Head + Acc).

add({Xa, Ya}, {Xb, Yb}) -> {add(Xa ,Xb), add(Ya, Yb)};
add(A, B) ->
	A + B.

divide(_A, B) when B == 0 -> infini;
divide(A, B) -> A/B.
