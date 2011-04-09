class AddColumn01 < ActiveRecord::Migration
  def self.up
    add_column :events, :mode, :string
    add_column :events, :show_key, :string
  end

  def self.down
  end
end
