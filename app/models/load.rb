class Load < ApplicationRecord
  enum load_type: %i[pallets5 pallets10 pallets26]

  validates :load_type, presence: true

  has_many :bids, dependent: :destroy
  has_many :carriers, through: :bids
  has_many :routes, through: :bids

  def display_load_type
    case load_type
    when 'pallets5' then '5 pallets'
    when 'pallets10' then '10 pallets'
    when 'pallets26' then '26 pallets'
    else load_type.to_s
    end
  end
end
