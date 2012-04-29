$ ->
  return unless window.isController "contacts"

  control_group_select = ".control-group input, .control-group textarea";
  $(control_group_select).focus(
    -> $(this).parents(".control-group:first").css({backgroundColor: "#FFF7C0"})
  )

  $(control_group_select).blur(
    -> $(this).parents(".control-group:first").css({backgroundColor: "#ffffff"})
  )