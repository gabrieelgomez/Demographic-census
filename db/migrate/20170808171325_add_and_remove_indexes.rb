class AddAndRemoveIndexes < ActiveRecord::Migration
  def change
    # remove_index :ckeditor_assets, :type
    #
    # add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"
    # add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  end
end
