class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :pdf
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
