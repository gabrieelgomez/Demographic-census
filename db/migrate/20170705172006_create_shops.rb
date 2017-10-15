class CreateShops < ActiveRecord::Migration
  def change
    unless table_exists? :shops
      create_table :shops do |t|
        t.string :brand
        t.string :header
        t.string :name
        t.integer :category_id
        t.text :address
        t.text :description
        t.string :email
        t.string :phone_one
        t.string :phone_two
        t.string :facebook
        t.string :instagram
        t.string :twitter

        t.timestamps null: false
      end
    end
  end
end
