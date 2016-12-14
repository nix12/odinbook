class RemoveLikeFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :like
  end
end
