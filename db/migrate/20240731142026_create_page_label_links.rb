class CreatePageLabelLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :page_label_links do |t|
      t.column :page_id, :integer
      t.column :label_id, :integer

      t.timestamps
    end
  end
end
