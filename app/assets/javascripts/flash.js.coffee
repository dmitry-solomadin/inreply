class Flash
  constructor: ->
    @$flashDivs = $(".flash_container")
    @$flashDiv = $(@$flashDivs[0])
    if !@$flashDiv
      @noFlashDiv = true
    return this
  add: (msg, type) ->
    if @noFlashDiv
      return
    @$flashDiv.append("<div class='alert alert-#{type}'>#{msg}</div>")
    return this
  discard: ->
    if @noFlashDiv
      return
    @$flashDiv.html("")
    return this
  use: (selector) ->
    @$flashDiv = $(@$flashDivs.filter(selector)[0])
    return this

$ ->
  window.flash = new Flash


