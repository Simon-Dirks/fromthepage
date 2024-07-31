class AddDisplayTextToPageLabelLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :page_label_links, :display_text, :string
  end
end
