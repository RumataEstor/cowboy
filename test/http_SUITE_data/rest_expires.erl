-module(rest_expires).

-export([init/3]).
-export([content_types_provided/1]).
-export([get_text_plain/1]).
-export([expires/1]).
-export([last_modified/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

content_types_provided(Req) ->
	{[{{<<"text">>, <<"plain">>, []}, get_text_plain}], Req}.

get_text_plain(Req) ->
	{<<"This is REST!">>, Req}.

expires(Req) ->
	{{{2012, 9, 21}, {22, 36, 14}}, Req}.

last_modified(Req) ->
	{{{2012, 9, 21}, {22, 36, 14}}, Req}.
