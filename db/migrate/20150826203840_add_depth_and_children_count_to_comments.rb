class AddDepthAndChildrenCountToComments < ActiveRecord::Migration
  def change
    add_column :comments, :depth, :integer
    add_column :comments, :children_count, :integer
  end
end
