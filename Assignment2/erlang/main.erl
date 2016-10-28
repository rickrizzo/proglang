-module(main).
-compile(export_all).

get_random_node() ->
  rget_random_node(rand:uniform(length(net_adm:world())), net_adm:world()).

rget_random_node(1, [H|_]) -> H;
rget_random_node(_, [H|[]]) -> H;
rget_random_node(N, [_|T]) -> rget_random_node(N-1, T).

findMatch(_, [], _) -> 0;
findMatch(MatchChar, [H|_], Count) when MatchChar =:= H -> Count + 1;
findMatch(MatchChar, [H|T], Count) when MatchChar =/= H ->
  findMatch(MatchChar, T, Count + 1).

merge(A, [], _, _) -> A;
merge([], B, _, _) -> B;
merge([HA|TA], [HB|TB], [HC|TC], PID) ->
  if
    HA == HC ->
      [HA | merge(TA, [HB|TB], TC, PID)];
    HB == HC ->
      PID ! {sum, 1},
      [HB | merge([HA|TA], TB, TC, PID)];
    true ->
      IndexA = findMatch(HC, [HA|TA], 0),
      IndexB = findMatch(HC, [HB|TB], 0),
      if
        IndexA > 0 ->
          PID ! {sum, IndexA},
          [HC | merge(lists:delete(HC, [HA|TA]), [HB|TB], TC, PID)];
        IndexB > 0 ->
          PID ! {sum, IndexB},
          [HC | merge([HA|TA], lists:delete(HC, [HB|TB]), TC, PID)];
        true->
          lists:append([[HA|TA], [HB|TB]])
      end
  end.

splitList([], _, _) -> [];
splitList([E], _, _) -> [E];
splitList(StartSeq, TargetSeq, PID) ->
  {A, B} = lists:split(trunc(length(StartSeq) / 2), StartSeq),
  {TarA, TarB} = lists:split(trunc(length(TargetSeq) / 2), TargetSeq),
  merge(splitList(A, TarA, PID), splitList(B, TarB, PID), TargetSeq, PID).

do_work(StartSeq, TargetSeq, PID) ->
  splitList(StartSeq, TargetSeq, PID),
  PID ! {ok}.

wait_for_done(Sum) ->
  receive
    {sum, A} -> wait_for_done(Sum + A);
    {ok} -> io:fwrite("~B~n", [Sum])
  end.

start() ->
  {ok, [StartSequence]} = io:fread("", "~s"),
  {ok, [TargetSequence]} = io:fread("", "~s"),
  case length(net_adm:world()) > 0 of
    true ->
      spawn(get_random_node(), main, do_work, [StartSequence, TargetSequence, self()]);
    false -> spawn(main, do_work, [StartSequence, TargetSequence, self()])
  end,
  wait_for_done(0).
