class CreateCategories < ActiveRecord::Migration
  def change
  	unless table_exists? :categories
	    create_table :categories do |t|
	      t.string :icon
	      t.string :name

	      t.timestamps null: false
	    end
    end
  end
end
