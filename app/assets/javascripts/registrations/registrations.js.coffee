$(->
  $("#add_location_button").click((e) ->
    locationManager.add()
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
      @onValidationPass()

  onValidationPass: ->
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

    locationTable = $("#locationTable")

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

  triggerValidation: ->
    @fields.trigger("change").trigger("focusout")

  clearData: ->
    @fields.val("")

  getFields: ->
    $("#location_name0, #location_address0, #location_city0")

locationManager = new LocationManager
