class Booking < ApplicationRecord
  has_many :invoices, dependent: :destroy
end
