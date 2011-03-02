class CreateTimesheetItems < ActiveRecord::Migration
  def self.up
    create_table :timesheet_items do |t|
      t.integer :timesheet_id
      t.date :date
      t.string :work_type
      t.integer :benefit_hours
      t.string :funeral_relation
      t.text :other_explanation
      t.timestamps
    end
  end

  def self.down
    drop_table :timesheet_items
  end
end
