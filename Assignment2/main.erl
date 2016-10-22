-module(main).
-compile(export_all).

inversion_count(StartSeq, TargetSeq) when StartSeq == [] -> 0;
inversion_count(StartSeq, TargetSeq) when hd(StartSeq) =:= hd(TargetSeq) -> 0 + inversion_count(tl(StartSeq), tl(TargetSeq));
inversion_count(StartSeq, TargetSeq) when hd(StartSeq) =/= hd(TargetSeq) -> 1 + inversion_count(tl(StartSeq), tl(TargetSeq)).

do_work(StartSeq, TargetSeq, PID) ->
  io:format("PID: ~p, StartSeq: ~p, TargetSeq: ~p~n", [PID, StartSeq, TargetSeq]),
  Count = inversion_count(StartSeq, TargetSeq),
  io:format("Mismatch Count: ~p~n", [Count]),
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
