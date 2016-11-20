%%%------------------------------------------------------------------------------
%%% @copyright (c) 2016, DuoMark International, Inc.
%%% @author Jay Nelson <jay@duomark.com>
%%% @reference The license is based on the template for Modified BSD from
%%%   <a href="http://opensource.org/licenses/BSD-3-Clause">OSI</a>
%%% @doc
%%%   Pied Piper receives URL requests and picks the data from them.
%%% @since 0.1.0
%%% @end
%%%------------------------------------------------------------------------------
-module(ppiper_app).
-behaviour(application).

-export([start/0, start/2]).
-export([stop/1]).

-type ast() :: application:start_type().

-spec start ()              ->  ok.
-spec start (ast(), term()) -> {ok, pid()}.
-spec stop  ([])            ->  ok.

start() ->
    application:start(ppiper).

start(_Type, _Args) ->
    ppiper_sup:start_link().

stop(_State) ->
    ok.
