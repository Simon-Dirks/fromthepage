class AddOriginalMetadataToWork < ActiveRecord::Migration
  def change
    add_column :works, :original_metadata, :json
  end
end
