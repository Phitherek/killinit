# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

fire_engines = ->
    if $("input#user_username").length > 0 && $("input#user_userkey").length > 0
        $("input#user_username").change( ->
            username_str = $("input#user_username").val()
            $.get("/helper/parameterize", { str: username_str }, (data) ->
                $("input#user_userkey").val(data)
                $("input#user_userkey").prop("value", data)
            )
        )
$(document).ready ->
    fire_engines()
$(document).on("page:load", ->
    fire_engines()
)