class CreateTimesheetCopies < ActiveRecord::Migration
  def self.up
    create_table :timesheet_copies do |t|
      t.integer :timesheet_id
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :timesheet_copies
  end
end
