class CreateTimesheets < ActiveRecord::Migration
  def self.up
    create_table :timesheets do |t|
      t.references    :user
      t.datetime      :start_date
      t.datetime      :stop_date
      t.string        :recipient
      t.timestamps
    end
    add_index :timesheets, [ :user_id ]
  end

  def self.down
    drop_table :timesheets
  end
end
