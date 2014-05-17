#!/usr/bin/env escript

main(_) ->
  {ok, [NumOfCases]} = io:fread("", "~d"),
  %%io:format("~p~n", [NumOfCases]).
  print_results(solve_cases(NumOfCases)).

solve_cases(0) -> [];
solve_cases(N) ->
  {ok, [ListSize, RepCount]} = io:fread("", "~d ~d"),
  %%io:format("~p, ~p ~n", [ListSize, RepCount]),
  [filter_elements(ListSize, RepCount) | solve_cases(N-1)].

filter_elements(Size, Count) ->
  List = string:tokens(string:strip(io:get_line(""), both, $\n), " "),
  if length(List) /= Size -> []
  ; length(List) == Size ->
    count_elem([list_to_integer(string:strip(X)) || X <- List], Count)
  end.

count_elem([], _C) -> [];
count_elem([X|Xs], C) ->
  ElemList = [Y || Y <- Xs, Y == X],
  NumOfElem = 1 + length(ElemList),
  %NumOfElem = count(Xs, X, C, 1),
  if NumOfElem >= C ->
    [X | count_elem(Xs -- ElemList, C)]
  ; NumOfElem < C -> count_elem(Xs -- ElemList, C)
  end.

count([], _Num, _Limit, Count) -> Count;
count([X|Xs], Num, Limit, Count) ->
  if Count < Limit ->
    if X == Num -> count(Xs, Num, Limit, Count+1)
    ; X /= Num -> count(Xs, Num, Limit, Count)
    end
  ; Count >= Limit -> Count
  end.

print_results([]) -> ok;
print_results([X|Xs]) ->
  if X == [] -> io:format("-1~n")
  ; X /= [] ->
    io:format(string:join([integer_to_list(Y) || Y <- X], " ") ++ "~n")
  end,
  print_results(Xs).
