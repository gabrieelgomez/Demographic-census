class CreatePhotos < ActiveRecord::Migration
  def change
  	unless table_exists? :photos
	    create_table :photos do |t|
	      t.string :picture
	      t.integer :album_id

	      t.timestamps null: false
	    end
    end
  end
end
