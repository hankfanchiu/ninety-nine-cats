class AddUserIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer

    Cat.update_all(user_id: 1)

    change_column :cats, :user_id, :integer, null: false
  end
end
