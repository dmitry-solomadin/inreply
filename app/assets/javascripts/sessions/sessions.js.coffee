showForgotPass = ->
  $(".login_box").animate({left: -2000})
  $(".forgot_pass_box").animate({left: -190})

showLogin = ->
  $(".login_box").animate({left: 255})
  $(".forgot_pass_box").animate({left: 2000})

$ ->
  $(".forgot_pass_link").click(->
    showForgotPass()
    return false
  )

  $("#back_to_login_button").click(->
    showLogin()
    return false
  )

  $(document).ajaxComplete((event, request) ->
    flash = $.parseJSON(request.getResponseHeader('X-Flash-Messages'))
    if !flash
      return
    if flash.notice
      $('.notice').html(flash.notice)
    if flash.failure
      alert(falsh.failure)
    if flash.error
      alert(flash.error)
  )



