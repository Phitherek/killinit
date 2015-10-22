# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ = jQuery

fire_engines = ->
    if $("input#user_username").length > 0 && $("input#user_userkey").length > 0
        $("input#user_username").on('input', ->
            username_str = $("input#user_username").val()
            $.get("/helper/parameterize", { str: username_str }, (data) ->
                $("input#user_userkey").val(data)
                $("input#user_userkey").prop("value", data)
            )
        )
    if $("input#users_search").length > 0
        $("input#users_search").on('input', ->
            $("form.users_search_form").submit()
        )
    if $("infinite_killin_it_listing").length > 0
        $("infinite_killin_it_listing").infinitePages
            loading: ->
                $(this).text('Loading next page...')
            error: ->
                $(this).text('Error while loading next page, please try again!')
$(document).ready ->
    fire_engines()
$(document).on("page:load", ->
    fire_engines()
)