class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.references  :user
      t.references  :entity, :polymorphic => true
      t.integer     :image_file_size
      t.string      :image_file_name
      t.string      :image_content_type
      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
