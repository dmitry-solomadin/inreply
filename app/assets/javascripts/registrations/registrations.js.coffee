$(->
  $("#add_location_button").click((e) ->
    window.locationManager.add()
    e.preventDefault()
  )
)

class LocationManager
  validationCallbacksAssigned: false

  constructor: ->
    $(=>
      @fields = @getFields()
    )

  add: ->
    @triggerValidation()
    allValid = true
    allValid = allValid and $(element).data("valid") == null for element in @fields
    if allValid
      locationName = $("#location_name0").val()
      locationAddress = $("#location_address0").val()
      locationCity = $("#location_city0").val()

      @clearData()

      locationHolder = $("#location_holder")
      locationHolder.show()

      # Create and append gray placeholder
      locationTopTr = $("#location-top-tr")
      locationTopTrHeight = locationTopTr.css("height")

      placeholder = $("<div class='placeholder'></div>")
      .css("width", locationTopTr.css("width"))
      .css("height", (locationTopTrHeight.substring(0, locationTopTrHeight.length - 2) * 4) + "px")
      .css("left", locationTopTr.offset().left)
      .css("top", locationTopTr.offset().top)
      $("body").append(placeholder)

      newLocationCount = parseInt($("#locationCount").html()) + 1
      # Create and append location div
      locationDiv = $("#locationTemplate").find("tr").clone()
      locationDiv.find(".locationNameTemplate").html(locationName)

      locationDiv.find(".locationName")[0].name = "locationName" + newLocationCount
      locationDiv.find(".locationName")[0].value = locationName
      locationDiv.find(".locationAddress")[0].name = "address" + newLocationCount
      locationDiv.find(".locationAddress")[0].value = locationAddress
      locationDiv.find(".locationCity")[0].name = "city" + newLocationCount
      locationDiv.find(".locationCity")[0].value = locationCity

      locationDiv.find(".locationWholeAddressTemplate").html(locationCity + ", " + locationAddress)

      locationDiv.find(".locationNameTemplate")[0].id = "locationName" + newLocationCount
      locationHolder.append(locationDiv)

      locationTable = $("#location_table")

      # animate placeholder to table, and animate table height.
      placeholder.animate(
        width: locationTable.css("width"),
        height: "50px",
        top: locationTable.offset().top,
        left: locationTable.offset().left,
        ->
          # Remove placeholder.
          placeholder.animate(opacity: 0, -> placeholder.remove())

          # Show location data.
          locationDiv.find(".locationData").animate({opacity: 1})

          $("#locationCount").html(newLocationCount)
      )

      locationTable.prepend(locationDiv)
      locationDiv.animate(height: "50px")

  edit: (element) ->
    locationTr = $(element).parents(".locationTr:first")
    locationTr.attr("id", "currentlyEditedLocation")

    # Extract location data
    locationName = locationTr.find(".locationName").val()
    locationAddress = locationTr.find(".locationAddress").val()
    locationCity = locationTr.find(".locationCity").val()

    # Create and append gray placeholder
    placeholder = $("<div class='placeholder'></div>")
    placeholder
    .css("width", locationTr.css("width"))
    .css("height", locationTr.css("height"))
    .css("left", locationTr.offset().left)
    .css("top", locationTr.offset().top)
    $("body").append(placeholder)

    locationTopTr = $("#location-top-tr")
    locationTopTrHeight = locationTopTr.css("height")
    placeholder.animate(
      width: locationTopTr.css("width"),
      height: (locationTopTrHeight.substring(0, locationTopTrHeight.length - 2) * 4) + "px",
      top: locationTopTr.offset().top,
      left: locationTopTr.offset().left, =>
        # Remove placeholder.
        placeholder.animate(opacity: 0, -> placeholder.remove())

        # Apply edited data to form fields and remove form fields names so they won't submit to server.
        $("#location_name0").val(locationName)
        $("#location_address0").val(locationAddress)
        $("#location_city0").val(locationCity)

        # remember thy name
        @obfuscateFieldNames()

        $("#add_location").hide()
        $("#edit_location").show()
    )

  confirmEdit: ->
    # deobfuscate field names before validation for correct validation
    @deobfuscateFieldNames()
    @triggerValidation()
    @obfuscateFieldNames()

    allValid = true
    allValid = allValid and $(element).data("valid") == null for element in @fields
    if allValid
      locationName = $("#location_name0").val()
      locationAddress = $("#location_address0").val()
      locationCity = $("#location_city0").val()

      @clearData()

      locationTr = $("#currentlyEditedLocation")
      locationTr.find(".locationName").val(locationName)
      locationTr.find(".locationAddress").val(locationAddress)
      locationTr.find(".locationCity").val(locationCity)

      @deobfuscateFieldNames()

      locationTr.find(".locationNameTemplate").html(locationName)
      locationTr.find(".locationWholeAddressTemplate").html(locationCity + ", " + locationAddress)

      $("#add_location").show()
      $("#edit_location").hide()

      locationTr.attr("id", "")

  cancelEdit: ->
    @clearData()

    @deobfuscateFieldNames()

    $("#add_location").show()
    $("#edit_location").hide()

    $("#currentlyEditedLocation").attr("id", "")

  remove: ($locationDiv) ->
    $locationDiv.animate(opacity: 0, =>
      newLocationCount = parseInt($("#locationCount").html()) - 1
      $("#locationCount").html(newLocationCount)
      $locationDiv.remove()

      $("#location_holder").hide() if newLocationCount == 0
    )

  triggerValidation: ->
    @fields.trigger("change").trigger("focusout")

  clearData: ->
    @fields.val("")

  obfuscateFieldNames: ->
    $(locationField).attr("oldName", $(locationField).attr("name")) for locationField in @fields
    @fields.attr("name", "field-name-removed")

  deobfuscateFieldNames: ->
    $(locationField).attr("name", $(locationField).attr("oldName")) for locationField in @fields

  getFields: ->
    $("#location_name0, #location_address0, #location_city0")

window.locationManager = new LocationManager
