class AddUserId < ActiveRecord::Migration
  def self.up
    add_column :events, :user_id, :integer
  end

  def self.down
  end
end
