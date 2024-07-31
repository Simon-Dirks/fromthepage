# == Schema Information
#
# Table name: labels
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Label < ApplicationRecord
  has_many :page_label_links, dependent: :destroy
  scope :page_label_links, -> { includes(:page) }

  has_many :pages, through: :page_label_links
end
