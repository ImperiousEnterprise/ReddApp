class AddLftToComments < ActiveRecord::Migration
  def change
    add_column :comments, :lft, :integer
    add_index :comments, :lft
  end
end
