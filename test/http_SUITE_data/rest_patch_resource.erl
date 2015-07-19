-module(rest_patch_resource).
-export([init/3, allowed_methods/1, content_types_provided/1, get_text_plain/1,
	content_types_accepted/1, patch_text_plain/1]).

init(_Transport, _Req, _Opts) ->
	{upgrade, protocol, cowboy_rest}.

allowed_methods(Req) ->
    {[<<"HEAD">>, <<"GET">>, <<"PATCH">>], Req}.

content_types_provided(Req) ->
    {[{{<<"text">>, <<"plain">>, []}, get_text_plain}], Req}.

get_text_plain(Req) ->
    {<<"This is REST!">>, Req}.

content_types_accepted(Req) ->
    case cowboy_req:method(Req) of
        {<<"PATCH">>, Req0} ->
            {[{{<<"text">>, <<"plain">>, []}, patch_text_plain}], Req0};
        {_, Req0} ->
            {[], Req0}
    end.

patch_text_plain(Req) ->
    case cowboy_req:body(Req) of
        {ok, <<"halt">>, Req0} ->
            {ok, Req1} = cowboy_req:reply(400, Req0),
            {halt, Req1};
        {ok, <<"false">>, Req0} ->
            {false, Req0};
        {ok, _Body, Req0} ->
            {true, Req0}
	end.
