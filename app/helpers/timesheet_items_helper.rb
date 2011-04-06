module TimesheetItemsHelper

#----------------------------------------------------------------------------
  def benefit_hours_visible?(timesheet_item)
    ['off', 'worked'].include?(timesheet_item.work_type) ? 'display:none;' : ''
  end

#----------------------------------------------------------------------------
  def start_date_value(timesheet)
    timesheet.start_date ? timesheet.start_date.strftime('%m/%d/%Y') : ''
  end

#----------------------------------------------------------------------------
  def stop_date_value(timesheet)
    timesheet.stop_date ? timesheet.stop_date.strftime('%m/%d/%Y') : ''
  end
end

