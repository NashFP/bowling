% Erlang Bowling game scorer
%
% Expects a list of scores as input, generates game score as output.
-module(bowling).
-export([score/1, strike/2, spare/2]).
% specials:
%   Strike: current + next two balls
%   Spare: current + next one ball

score([]) -> 0;
score([[N1,N2,N3]]) when N1 =:= 10 ->
    N1 + N2 + N3; %final frame
score([[N1,N2]|L]) when N1 =:= 10 ->
    strike([N1,N2], L) + score(L);
score([[N1,N2]|L]) when N1 + N2 =:= 10 ->
    spare([N1,N2], L) + score(L);
score([[N1,N2]|L]) -> N1 + N2 + score(L);
score([[N]|L]) when N =:= 10 ->
    strike([N,0], L) + score(L);
score([[N]|L]) -> N + score(L).

strike([N1,N2], L) when N2 > 0 ->
    case L of
        [[N3]] -> N1 + N2 + N3;
        [] -> N1 + N2
    end;
strike([N1,_], L) when length(L) > 0 ->
    case L of
        [[N3,N4]|_] -> N1 + N3 + N4;
        [[N3,N4,_]|_] -> N1 + N3 + N4;
        [[N3]|T] ->
            case T of
                [[N4]|_] -> N1 + N3 + N4;
                [[N4,_,_]|_] -> N1 + N3 + N4; %final frame
                [] -> N1 + N3
            end
    end;
strike([N1,N2], _) ->
    N1 + N2.

spare([N1,N2], L) ->
    case L of
        [[N3,_]] -> N1 + N2 + N3;
        [] -> N1 + N2
    end.
