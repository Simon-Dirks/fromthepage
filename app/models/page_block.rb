# == Schema Information
#
# Table name: page_blocks
#
#  id          :integer          not null, primary key
#  controller  :string(255)
#  description :string(255)
#  html        :text(65535)
#  tag         :string(255)
#  view        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_page_blocks_on_controller_and_view  (controller,view)
#
class PageBlock < ApplicationRecord
  attr_accessor :rendered_html
end
