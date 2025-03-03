class Carrier < ApplicationRecord
  validates :carrier_name, presence: true, uniqueness: true

  has_many :bids, dependent: :destroy
  has_many :loads, through: :bids
  has_many :routes, through: :bids
end
