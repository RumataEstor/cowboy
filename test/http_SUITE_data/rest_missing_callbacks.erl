-module(rest_missing_callbacks).
-export([init/3]).
-export([allowed_methods/1]).
-export([content_types_accepted/1]).
-export([content_types_provided/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

allowed_methods(Req) ->
	{[<<"GET">>, <<"PUT">>], Req}.

content_types_accepted(Req) ->
	cowboy_error_h:ignore(cowboy_rest, process_content_type, 3),
	{[
		{<<"application/json">>, put_application_json}
	], Req}.

content_types_provided(Req) ->
	cowboy_error_h:ignore(cowboy_rest, set_resp_body, 2),
	{[
		{<<"text/plain">>, get_text_plain}
	], Req}.
