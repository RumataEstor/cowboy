-module(rest_simple_resource).
-export([init/3, content_types_provided/1, get_text_plain/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

content_types_provided(Req) ->
	{[{{<<"text">>, <<"plain">>, []}, get_text_plain}], Req}.

get_text_plain(Req) ->
	{<<"This is REST!">>, Req}.

