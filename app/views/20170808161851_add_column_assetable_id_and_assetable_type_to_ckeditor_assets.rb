class AddColumnAssetableIdAndAssetableTypeToCkeditorAssets < ActiveRecord::Migration
  def change
    add_column :ckeditor_assets, :assetable_id, :integer
    add_column :ckeditor_assets, :assetable_type, :string
  end
end
