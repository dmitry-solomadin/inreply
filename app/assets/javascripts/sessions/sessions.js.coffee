showForgotPass = ->
  $(".login_box").animate({left: -2000})
  $(".forgot_pass_box").animate({left: -190})

showLogin = ->
  $(".login_box").animate({left: 255})
  $(".forgot_pass_box").animate({left: 2000})

$ ->
  return unless window.isController "sessions"

  $(".forgot_pass_link").click(->
    showForgotPass()
    return false
  )

  $("#back_to_login_button").click(->
    showLogin()
    return false
  )



