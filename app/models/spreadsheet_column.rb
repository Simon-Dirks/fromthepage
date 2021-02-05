class SpreadsheetColumn < ApplicationRecord
  belongs_to :transcription_field
  acts_as_list :scope => :transcription_field

  validates :options, presence: true, if: Proc.new {|field| field.input_type == 'select'}, on: [:create, :update]

  validates :percentage, numericality: { allow_nil: true, greater_than: 0, less_than_or_equal_to: 100 }

  INPUTS = ["text", "numeric", "select", "checkbox"]

end