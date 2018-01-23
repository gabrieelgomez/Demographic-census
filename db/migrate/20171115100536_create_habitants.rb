class CreateHabitants < ActiveRecord::Migration
  def change
    create_table :habitants do |t|
      t.integer :identification
      t.string :full_name
      t.string :phone
      t.string :email
      t.text :address

      t.timestamps null: false
    end
  end
end
