class ChangeIntegerToString < ActiveRecord::Migration
  def change
    change_column :habitants, :identification, :string 
  end
end
