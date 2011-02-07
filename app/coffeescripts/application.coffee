jQuery(document).bind "ready", () =>

##----------------------------------------------------------------------------
## Common
##----------------------------------------------------------------------------
  $('.datepicker').datepicker({changeYear: true, yearRange: "-110:+0"})

##----------------------------------------------------------------------------
  $('.title_tools').children('a').mouseenter () ->
    $(this).children('span.ui-icon').addClass('ui-icon-white')
  $('.title_tools').children('a').mouseleave () ->
    $(this).children('span.ui-icon').removeClass('ui-icon-white')

##----------------------------------------------------------------------------
  $('#search').bind('keyup', () ->
    controller = $(this).data('path')
    list = controller
    query = $(this).val()
    if list.indexOf("/") >= 0
      list = list.split("/")[1]
    $("#loading").show()
    $("##{list}").css({ opacity: 0.4 })
    $.ajax({
      url: "#{controller}/search?query=#{query}",
      method: "get",
      success: () ->
        $("#loading").hide()
        $("##{list}").css({ opacity: 1 })
    })
  )

##----------------------------------------------------------------------------
  $.ajaxSetup({
    'beforeSend': (xhr) ->
      xhr.setRequestHeader("Accept", "text/javascript")
  })
  
##----------------------------------------------------------------------------
  $('.pagination a').live('click', () ->
    $('#paging').show()
    url = $(this).data('link')
    $.ajax({
      url: url,
      method: "get",
      success: () ->
        $('#paging').hide()
    })
  )

##----------------------------------------------------------------------------
## Timesheets
##----------------------------------------------------------------------------
  timesheetOptionsValidator = $("#timesheet_options_form").validate({
     onkeyup: false,
     onfocusout: false,
     highlight: (element, errorClass, validClass) ->
         $(element).addClass(errorClass).removeClass(validClass)
         $(element.form).find("label[for=" + element.id + "]").addClass(errorClass);
     unhighlight: (element, errorClass, validClass) ->
         $(element).removeClass(errorClass).addClass(validClass);
         $(element.form).find("label[for=" + element.id + "]").removeClass(errorClass);
     errorContainer: "#errorExplanation",
     errorLabelContainer: "#errorExplanation ul",
     wrapper: "li",
     showErrors: (errorMap, errorList) =>    
       errors = timesheetOptionsValidator.numberOfInvalids()
       if (errors)
         if errors == 1
           message= "1 error prohibited these timesheet options from being saved"
         else
           message= "#{errors} errors prohibited these timesheet options from being saved"
         $("div#errorExplanation h2").html(message)
         $("div#errorExplanation").show()
       else
         $("div#errorExplanation").hide()
       timesheetOptionsValidator.defaultShowErrors()
     rules: {
       "recipient": {
         required: true,
         email: true
       }
     },
     messages: {
       "recipient": {
         required: "Timesheet recipient email can't be blank",
         email: "Timesheet recipient email must be a valid email address"
       }
     }
  })
  

##----------------------------------------------------------------------------
## daysheet namespace
##----------------------------------------------------------------------------
window.daysheet = {

  flash: (type, sticky) ->
    $("#flash").hide()
    if type == "warning" || type == "error" || type == "alert"
      $("#flash").addClass("flash_warning")
    else
      $("#flash").addClass("flash_notice")
    $("#flash").show()
    if !sticky
      setTimeout("$('#flash').fadeOut('slow');", 3000)
  ##----------------------------------------------------------------------------
}
##----------------------------------------------------------------------------

      
