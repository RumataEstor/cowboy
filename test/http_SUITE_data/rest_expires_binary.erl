-module(rest_expires_binary).

-export([init/3]).
-export([content_types_provided/1]).
-export([get_text_plain/1]).
-export([expires/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

content_types_provided(Req) ->
	{[{{<<"text">>, <<"plain">>, []}, get_text_plain}], Req}.

get_text_plain(Req) ->
	{<<"This is REST!">>, Req}.

expires(Req) ->
	{<<"0">>, Req}.
