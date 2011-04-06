class CreateTimesheetRecipients < ActiveRecord::Migration
  def self.up
    remove_column :timesheets, :recipient
    create_table :timesheet_recipients do |t|
      t.integer :timesheet_id
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :timesheet_recipients
    add_column :timesheets, :recipient, :string
  end
end
