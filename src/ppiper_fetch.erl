%%%------------------------------------------------------------------------------
%%% @copyright (c) 2016, DuoMark International, Inc.
%%% @author Jay Nelson <jay@duomark.com>
%%% @reference The license is based on the template for Modified BSD from
%%%   <a href="http://opensource.org/licenses/BSD-3-Clause">OSI</a>
%%% @doc
%%%   The fetcher is a gen_event.
%%% @since 0.1.0
%%% @end
%%%------------------------------------------------------------------------------
-module(ppiper_fetch).
-author('Jay Nelson <jay@duomark.com>').
-behaviour(gen_event).

%% External API
-export([start_link/0, add_handler/0]).

%% gen_event callbacks
-export([init/1, handle_event/2, handle_call/2, 
         handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).
-type state() :: #state{}.


%%%===================================================================
%%% External API
%%%===================================================================

-spec start_link() -> {ok, pid()}.
-spec add_handler() -> term().

start_link  () -> gen_event:start_link  ({local, ?SERVER}).
add_handler () -> gen_event:add_handler (?SERVER, ?MODULE, {}).


%%%===================================================================
%%% gen_event callbacks
%%%===================================================================

-spec init          ({})                         -> {ok, state()}.
-spec terminate     (any(),   state())           ->  ok.
-spec code_change   (any(),   state(),    any()) -> {ok, state()}.
%%% -spec format_status (normal | terminate, list()) -> any().

init        ({})                      -> {ok, #state{}}.
terminate   (_Reason, _State)         ->  ok.
code_change (_OldVsn,  State, _Extra) -> {ok, State}.


-spec handle_event (any(), state()) -> {ok,        state()}.
-spec handle_info  (any(), state()) -> {ok,        state()}.
-spec handle_call  (any(), state()) -> {ok, any(), state()}.

handle_event (_Event,   #state{} = State) -> {ok,     State}.
handle_info  (_Info,    #state{} = State) -> {ok,     State}.
handle_call  (_Request, #state{} = State) -> {ok, ok, State}.


%%%===================================================================
%%% Internal functions
%%%===================================================================
