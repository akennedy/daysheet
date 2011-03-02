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

  displayDate= (date) ->
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    return "#{days[date.getDay()]} #{months[date.getMonth()]} #{date.getDate()} #{date.getFullYear()}"

  buildWorklogTable= () ->
    $('#dates_worked').html('')
    $('#dates_worked').append("<fieldset><table id='dates_worked_list'></table></fieldset>")
    date = new Date($('#timesheet_start_date').val())
    stop_date = new Date($('#timesheet_stop_date').val())
    if date < stop_date
      i = 0
      while date <= stop_date
        $('#dates_worked_list').append("<tr style='width:100%;height:30px;'>
                                            <input type='hidden' value='#{date.getMonth() + 1}/#{date.getDate()}/#{date.getFullYear()}' name='timesheet[timesheet_items_attributes][][date]'></input>
                                            <td style='width:21%;'><label>#{displayDate(date)}</label></td>
                                            <td style='width:10%;'><select class='day_option' data-benefit_hours_id='#{i}' name='timesheet[timesheet_items_attributes][][work_type]'><option value='worked'>Worked</option><option value='pto'>PTO</option><option value='fmla'>FMLA</option><option value='funeral'>Funeral</option><option value='jury_duty'>Jury Duty</option><option value='other'>Other</option><option value='off'>Off/Weekend</option></select></td>
                                            <td style='width:21%;'><input type='text' id='benefit_hours_#{i}' style='display:none;width:80px;margin-left:10px;' name='timesheet[timesheet_items_attributes][][benefit_hours]'></input></td>
                                            <td style='width:49%;'>&nbsp;</td></tr>")
        date.setDate(date.getDate() + 1)
        i++
    else
      $('#dates_worked_list').html('Start date has to be before stop date.')

  $('#timesheet_start_date').live('change', () ->
    $('#dates_worked').html('')
    if $(this).val() && $('#timesheet_stop_date').val()
      buildWorklogTable()
  )

  $('.day_option').live('change', () ->
    id = $(this).data('benefit_hours_id')
    if $(this).val() != 'worked' && $(this).val() != 'off'
      $('#benefit_hours_' + id).show()
    else
      $('#benefit_hours_' + id).hide()
      $('#benefit_hours_' + id).val('')
  )

  $('#timesheet_stop_date').live('change', () ->
    if $(this).val() && $('#timesheet_start_date').val()
      buildWorklogTable()
  )


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


