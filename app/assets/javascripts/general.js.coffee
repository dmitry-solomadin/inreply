$(document).bind('ajaxSend', (e, request, options) ->
  $('[data-loading-text]').button('loading')
)

$(document).bind('ajaxComplete', (e, request, options) ->
  $('[data-loading-text]').button('complete')
)

window.isController = (controller) ->
  $("body").data()["controller"]? and $("body").data()["controller"].indexOf(controller) != -1