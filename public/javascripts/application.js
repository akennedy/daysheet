/* DO NOT MODIFY. This file was compiled from
 *   /Users/andrew/apps/daysheet/app/coffeescripts/application.coffee
 */

(function() {
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
  jQuery(document).bind("ready", (__bind(function() {
    var timesheetOptionsValidator;
    $('.datepicker').datepicker({
      changeYear: true,
      yearRange: "-110:+0"
    });
    $('.title_tools').children('a').mouseenter(function() {
      return $(this).children('span.ui-icon').addClass('ui-icon-white');
    });
    $('.title_tools').children('a').mouseleave(function() {
      return $(this).children('span.ui-icon').removeClass('ui-icon-white');
    });
    $('#search').bind('keyup', function() {
      var controller, list, query;
      controller = $(this).data('path');
      list = controller;
      query = $(this).val();
      if (list.indexOf("/") >= 0) {
        list = list.split("/")[1];
      }
      $("#loading").show();
      $("#" + (list)).css({
        opacity: 0.4
      });
      return $.ajax({
        url: ("" + (controller) + "/search?query=" + (query)),
        method: "get",
        success: function() {
          $("#loading").hide();
          return $("#" + (list)).css({
            opacity: 1
          });
        }
      });
    });
    $.ajaxSetup({
      'beforeSend': function(xhr) {
        return xhr.setRequestHeader("Accept", "text/javascript");
      }
    });
    $('.pagination a').live('click', function() {
      var url;
      $('#paging').show();
      url = $(this).data('link');
      return $.ajax({
        url: url,
        method: "get",
        success: function() {
          return $('#paging').hide();
        }
      });
    });
    return (timesheetOptionsValidator = $("#timesheet_options_form").validate({
      onkeyup: false,
      onfocusout: false,
      highlight: function(element, errorClass, validClass) {
        $(element).addClass(errorClass).removeClass(validClass);
        return $(element.form).find("label[for=" + element.id + "]").addClass(errorClass);
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).removeClass(errorClass).addClass(validClass);
        return $(element.form).find("label[for=" + element.id + "]").removeClass(errorClass);
      },
      errorContainer: "#errorExplanation",
      errorLabelContainer: "#errorExplanation ul",
      wrapper: "li",
      showErrors: (__bind(function(errorMap, errorList) {
        var errors, message;
        errors = timesheetOptionsValidator.numberOfInvalids();
        if (errors) {
          if (errors === 1) {
            message = "1 error prohibited these timesheet options from being saved";
          } else {
            message = ("" + (errors) + " errors prohibited these timesheet options from being saved");
          }
          $("div#errorExplanation h2").html(message);
          $("div#errorExplanation").show();
        } else {
          $("div#errorExplanation").hide();
        }
        return timesheetOptionsValidator.defaultShowErrors();
      }, this)),
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
    }));
  }, this)));
  window.daysheet = {
    flash: function(type, sticky) {
      $("#flash").hide();
      if (type === "warning" || type === "error" || type === "alert") {
        $("#flash").addClass("flash_warning");
      } else {
        $("#flash").addClass("flash_notice");
      }
      $("#flash").show();
      return !sticky ? setTimeout("$('#flash').fadeOut('slow');", 3000) : null;
    }
  };
}).call(this);