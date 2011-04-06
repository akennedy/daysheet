class TimesheetItem < ActiveRecord::Base
  belongs_to :timesheet

  validate :validate_timesheet_item

  WORK_TYPES = [{:name => 'Worked', :value => 'worked'},
                {:name => 'PTO', :value => 'pto'},
                {:name => 'FMLA', :value => 'fmla'},
                {:name => 'Funeral', :value => 'funeral'},
                {:name => 'Jury Duty', :value => 'jury_duty'},
                {:name => 'Other', :value => 'other'},
                {:name => 'Off/Weekend', :value => 'off'}]

  def validate_timesheet_item
    unless ['worked', 'off'].include?(self.work_type)
      self.errors.add(:benefit_hours, "must be inserted on days that were taken off.") if self.benefit_hours.blank?
    end
  end
end
