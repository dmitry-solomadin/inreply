class FormErrors
  replace: (newHtml) -> $("#form_errors_div").html newHtml

$ -> window.formErrors = new FormErrors