class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, null: false
      t.string :status, null: false, default: "PENDING"
      t.string :start_date, null: false
      t.string :end_date, null: false

      t.timestamps null: false
    end
    add_index :cat_rental_requests, :cat_id
  end
end
