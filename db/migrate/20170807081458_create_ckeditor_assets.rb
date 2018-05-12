class CreateCkeditorAssets < ActiveRecord::Migration
  unless table_exists? :ckeditor_assets
    create_table :ckeditor_assets do |t|
      t.string  :data_file_name, null: false
      t.string  :data_content_type
      t.integer :data_file_size
      t.string  :type, limit: 30

      # Uncomment it to save images dimensions, if your need it
      t.integer :width
      t.integer :height

      t.timestamps null: false


      # add_index :ckeditor_assets, :type
    end
  end
end
