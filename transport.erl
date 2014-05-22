#!/usr/bin/env escript
%-module(transport).
%-export([main/0]).

main(_) ->
    {ok, [NumOfPeople, P]} = io:fread("", "~d~d"),
    io:format("~p~n", [cost(unite_all(create(NumOfPeople), P), lists:seq(1, NumOfPeople),0)]).

cost(_Ids, [], Cost) -> Cost;
cost(Ids, Index, Cost) ->
    %io:format("~p~n", [Index]),
    Group = [X || X <- Index, root(lists:nth(1, Index), Ids) == root(X, Ids)],
    RemIdx = Index -- Group,
    cost(Ids, RemIdx, Cost + ceiling(math:sqrt(length(Group)))).

unite_all(Ids, 0) -> Ids;
unite_all(Ids, N) ->
    {ok, [P, Q]} = io:fread("", "~d ~d"),
    if P == Q -> unite_all(Ids, N-1)
    ; P /= Q -> unite_all(union(P, Q, Ids), N-1)
    end.

create(N) -> lists:seq(1, N).

union(P, Q, Ids) ->
    {Rp, Sp} = root(P, Ids, 0),
    {Rq, Sq} = root(Q, Ids, 0),
    if Sp < Sq ->
      lists:sublist(Ids, Rp-1) ++ [lists:nth(Rq, Ids)] ++ lists:sublist(Ids, Rp+1, length(Ids))
    ; Sp >= Sq ->
      lists:sublist(Ids, Rq-1) ++ [lists:nth(Rp, Ids)] ++ lists:sublist(Ids, Rq+1, length(Ids))
    end.

root(P, Ids) ->
    Id = lists:nth(P, Ids),
    if (Id =:= P) -> P
    ; true -> root(Id, Ids)
    end.

root(P, Ids, Sz) ->
    Id = lists:nth(P, Ids),
    if (Id =:= P) -> {P, Sz}
    ; true -> root(Id, Ids, Sz+1)
    end.

find(P, Q, Ids) -> root(P, Ids) == root(Q, Ids).

%% help functions
ceiling(X) ->
    if trunc(X) - X < 0 -> trunc(X) + 1
    ; trunc(X) - X >= 0 -> trunc(X)
    end.
