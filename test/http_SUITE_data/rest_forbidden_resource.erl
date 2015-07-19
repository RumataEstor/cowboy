-module(rest_forbidden_resource).
-export([init/3, rest_init/2, allowed_methods/1, forbidden/1,
		content_types_provided/1, content_types_accepted/1,
		to_text/1, from_text/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

rest_init(Req, [Forbidden]) ->
	{ok, Req, [{forbidden, Forbidden}]}.

allowed_methods(Req) ->
	{[<<"GET">>, <<"HEAD">>, <<"POST">>], Req}.

forbidden(Req) ->
    {[forbidden], Req,
     fun(Forbidden) ->
             Forbidden
     end}.

content_types_provided(Req) ->
	{[{{<<"text">>, <<"plain">>, []}, to_text}], Req}.

content_types_accepted(Req) ->
	{[{{<<"text">>, <<"plain">>, []}, from_text}], Req}.

to_text(Req) ->
	{<<"This is REST!">>, Req}.

from_text(Req) ->
	{Path, Req2} = cowboy_req:path(Req),
	{{true, Path}, Req2}.
