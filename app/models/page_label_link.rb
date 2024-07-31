# == Schema Information
#
# Table name: page_label_links
#
#  id           :bigint           not null, primary key
#  display_text :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  label_id     :integer
#  page_id      :integer
#
class PageLabelLink < ApplicationRecord
  belongs_to :page, optional: true
  belongs_to :label, optional: true
end
