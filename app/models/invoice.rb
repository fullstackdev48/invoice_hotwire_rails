class Invoice < ApplicationRecord
  belongs_to :booking, optional: true
  has_many :line_items, dependent: :destroy
  has_one_attached :pdf

  accepts_nested_attributes_for :line_items, allow_destroy: true
  
  validates :pdf, presence: true
end
