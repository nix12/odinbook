class AddLikesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :like, :integer
  end
end
