-module(rest_resource_etags).
-export([init/3, generate_etag/1, content_types_provided/1, get_text_plain/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

generate_etag(Req) ->
	case cowboy_req:qs_val(<<"type">>, Req) of
		%% Correct return values from generate_etag/2.
		{<<"tuple-weak">>, Req2} ->
			{{weak, <<"etag-header-value">>}, Req2};
		{<<"tuple-strong">>, Req2} ->
			{{strong, <<"etag-header-value">>}, Req2};
		%% Backwards compatible return values from generate_etag/2.
		{<<"binary-weak-quoted">>, Req2} ->
			{<<"W/\"etag-header-value\"">>, Req2};
		{<<"binary-strong-quoted">>, Req2} ->
			{<<"\"etag-header-value\"">>, Req2};
		%% Invalid return values from generate_etag/2.
		{<<"binary-strong-unquoted">>, Req2} ->
			cowboy_error_h:ignore(cowboy_http, quoted_string, 2),
			{<<"etag-header-value">>, Req2};
		{<<"binary-weak-unquoted">>, Req2} ->
			cowboy_error_h:ignore(cowboy_http, quoted_string, 2),
			{<<"W/etag-header-value">>, Req2}
	end.

content_types_provided(Req) ->
	{[{{<<"text">>, <<"plain">>, []}, get_text_plain}], Req}.

get_text_plain(Req) ->
	{<<"This is REST!">>, Req}.
