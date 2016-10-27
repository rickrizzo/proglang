-module(main).
-compile(export_all).
findMatch(_, [], Count) -> 0;
findMatch(MatchChar, [H|_], Count) when MatchChar =:= H -> Count + 1;
findMatch(MatchChar, [H|T], Count) when MatchChar =/= H ->
  findMatch(MatchChar, T, Count + 1).

merge(A, [], _) -> A;
merge([], B, _) -> B;
merge([HA|TA], [HB|TB], [HC|TC]) ->
  if
    HA == HC ->
      [HA | merge(TA, [HB|TB], TC)];
    HB == HC ->
      io:format("+1~n"),
      [HB | merge([HA|TA], TB, TC)];
    true ->
      IndexA = findMatch(HC, [HA|TA], 0),
      IndexB = findMatch(HC, [HB|TB], 0),
      if
        IndexA > 0 ->
          io:format("+~p~n", [IndexA]),
          [HC | merge(lists:delete(HC, [HA|TA]), [HB|TB], TC)];
        IndexB > 0 ->
          io:format("+~p~n", [IndexB]),
          [HC | merge([HA|TA], lists:delete(HC, [HB|TB]), TC)];
        true-> io:format("NO MATCH! ~p ~p ~p~n", [HA, HB, HC]), lists:append([[HA|TA], [HB|TB]])
      end
  end.

splitList([], _) -> [];
splitList([E], _) -> [E];
splitList(StartSeq, TargetSeq) ->
  {A, B} = lists:split(trunc(length(StartSeq) / 2), StartSeq),
  {TarA, TarB} = lists:split(trunc(length(TargetSeq) / 2), TargetSeq),
  merge(splitList(A, TarA), splitList(B, TarB), TargetSeq).

do_work(StartSeq, TargetSeq, PID) ->
  io:format("~p~n", [splitList(StartSeq, TargetSeq)]),
  PID ! {ok, 4}.

wait_for_done() ->
  receive
    {ok, Result} -> io:fwrite("~B~n", [Result])
  end.

start() ->
  {ok, [StartSequence]} = io:fread("", "~s"),
  {ok, [TargetSequence]} = io:fread("", "~s"),
  spawn(main, do_work, [StartSequence, TargetSequence, self()]),
  wait_for_done().
