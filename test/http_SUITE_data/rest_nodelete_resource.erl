-module(rest_nodelete_resource).
-export([init/3, allowed_methods/1, content_types_provided/1,
		get_text_plain/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

allowed_methods(Req) ->
	{[<<"GET">>, <<"HEAD">>, <<"DELETE">>], Req}.


content_types_provided(Req) ->
	{[{{<<"text">>, <<"plain">>, []}, get_text_plain}], Req}.

get_text_plain(Req) ->
	{<<"This is REST!">>, Req}.

