class Route < ApplicationRecord
  validates :from, presence: true
  validates :to, presence: true

  has_many :bids, dependent: :destroy
  has_many :carriers, through: :bids
  has_many :loads, through: :bids
end
