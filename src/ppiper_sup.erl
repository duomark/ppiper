%%%------------------------------------------------------------------------------
%%% @copyright (c) 2016, DuoMark International, Inc.
%%% @author Jay Nelson <jay@duomark.com>
%%% @reference The license is based on the template for Modified BSD from
%%%   <a href="http://opensource.org/licenses/BSD-3-Clause">OSI</a>
%%% @doc
%%%   The supervisor manages a gen_event which acts on URL requests.
%%% @since 0.1.0
%%% @end
%%%------------------------------------------------------------------------------
-module(ppiper_sup).
-behaviour(supervisor).

%%% External API
-export([start_link/0]).

%%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).


%%%------------------------------------------------------------------------------
%%% External API
%%%------------------------------------------------------------------------------

-spec start_link() -> {ok, pid()}.

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, {}).


%%%------------------------------------------------------------------------------
%%% Internal API
%%%------------------------------------------------------------------------------

-spec init({}) -> {ok, {supervisor:sup_flags(), [supervisor:child_spec()]}}.

init({}) ->
    Children = [make_child_spec(Mod) || Mod <- [ppiper_fetch]],
    {ok, {make_sup_flags(), Children}}.

make_sup_flags() ->
    #{
      strategy  => one_for_one,
      intensity => 5,
      period    => 1
     }.

make_child_spec(Module) ->
    #{
       id       =>  Module,
       start    => {Module, start_link, []},
       restart  => permanent,
       type     => worker,
       modules  => [Module]
     }.
