class RemoveLgtFromComments < ActiveRecord::Migration
  def change
    remove_column :comments , :lgt
  end
end
