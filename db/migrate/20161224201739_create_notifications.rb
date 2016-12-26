class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.boolean :checked, default: false

      t.timestamps null: false
    end
  end
end
