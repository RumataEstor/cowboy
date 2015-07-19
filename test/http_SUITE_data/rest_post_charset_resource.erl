-module(rest_post_charset_resource).
-export([init/3, allowed_methods/1, content_types_accepted/1, from_text/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

allowed_methods(Req) ->
	{[<<"POST">>], Req}.

content_types_accepted(Req) ->
	{[{{<<"text">>, <<"plain">>, [{<<"charset">>, <<"utf-8">>}]},
		from_text}], Req}.

from_text(Req) ->
	{true, Req}.
