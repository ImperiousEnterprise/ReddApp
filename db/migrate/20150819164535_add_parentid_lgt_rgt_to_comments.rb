class AddParentidLgtRgtToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer
    add_column :comments, :lgt, :integer
    add_column :comments, :rgt, :integer

    # This is necessary to update :lft and :rgt columns
    add_index :comments, :parent_id
    add_index :comments, :lgt
    add_index :comments, :rgt
  end
end
