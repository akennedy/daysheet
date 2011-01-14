class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string   :username
      t.string   :email
      t.string   :first_name
      t.string   :mi
      t.string   :last_name
      t.string   :title
      t.string   :company
      t.string   :alt_email
      t.string   :phone
      t.string   :mobile
      t.datetime :suspended_at
      t.datetime :deleted_at
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end