#!/usr/bin/env escript
%-module(transport).
%-export([main/0]).

main(_) ->
    {ok, [NumOfUnions, P]} = io:fread("", "~d~d"),
    io:format("~p~n", [unite_all(create(NumOfUnions), P)]).

unite_all(Ids, 0) -> Ids;
unite_all(Ids, N) -> 
    {ok, [P, Q]} = io:fread("", "(~d ~d)"),
    if P == Q -> unite_all(Ids, N-1)
    ; P /= Q -> unite_all(union(P, Q, Ids), N-1)
    end.

create(N) -> lists:seq(1, N).

union(P, Q, Ids) ->
    Rp = root(P, Ids),
    Rq = root(Q, Ids), 
    lists:sublist(Ids, Rp-1) ++ [lists:nth(Rq, Ids)] ++ lists:sublist(Ids, Rp+1, length(Ids)).

root(P, Ids) ->
    Id = lists:nth(P, Ids),
    if (Id =:= P) -> P
    ; true -> root(lists:nth(P, Ids), Ids)
    end.


