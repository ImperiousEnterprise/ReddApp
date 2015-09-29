class RemoveVariousFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :lft, :integer
    remove_column :comments, :rgt, :integer
    remove_column :comments, :depth, :integer
    remove_column :comments, :children_count, :integer
  end
end
