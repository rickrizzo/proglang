-module(pingpong).
-export([ start_ping/1, start_pong/0, ping/1, pong/0 ]).

start_ping(Receiver) -> spawn(pingpong, ping, [ Receiver ]).

ping(Receiver) ->
  { pong, Receiver } ! { ping, self() },
  receive
    pong -> io:format("Got pong!~n")
  end.


start_pong() ->
  register(pong, spawn(pingpong, pong, [])).

pong() ->
  receive

    finished ->
      io:format("Pong finished~n");

    { ping, Sender } ->
      io:format("Got ping!~n"),
      Sender ! pong,
      pong()
  end.
