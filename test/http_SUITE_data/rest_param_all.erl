-module(rest_param_all).

-export([init/3]).
-export([allowed_methods/1]).
-export([content_types_provided/1]).
-export([get_text_plain/1]).
-export([content_types_accepted/1]).
-export([put_text_plain/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

allowed_methods(Req) ->
	{[<<"GET">>, <<"PUT">>], Req}.

content_types_provided(Req) ->
	{[{{<<"text">>, <<"plain">>, '*'}, get_text_plain}], Req}.

get_text_plain(Req) ->
	{{_, _, Param}, Req2} =
		cowboy_req:meta(media_type, Req, {{<<"text">>, <<"plain">>}, []}),
	Body = if
	Param == '*' ->
		<<"'*'">>;
	Param == [] ->
		<<"[]">>;
	Param /= [] ->
		iolist_to_binary([[Key, $=, Value] || {Key, Value} <- Param])
	end,
	{Body, Req2}.

content_types_accepted(Req) ->
	{[{{<<"text">>, <<"plain">>, '*'}, put_text_plain}], Req}.

put_text_plain(Req) ->
	{true, Req}.
