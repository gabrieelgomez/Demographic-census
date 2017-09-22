class CreateNewsletters < ActiveRecord::Migration
  def change
  	unless table_exists? :newsletters
	    create_table :newsletters do |t|
	      t.string :email

	      t.timestamps null: false
	    end
    end
  end
end
