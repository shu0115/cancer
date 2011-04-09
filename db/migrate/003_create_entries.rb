class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :name
      t.date :schedule_day
      t.string :attend
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
