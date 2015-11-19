class AddUserIdToCatRentalRequests < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer

    CatRentalRequest.update_all(user_id: 2)

    change_column :cat_rental_requests, :user_id, :integer, null: false
  end
end
