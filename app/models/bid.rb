class Bid < ApplicationRecord
  belongs_to :carrier
  belongs_to :load
  belongs_to :route

  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected' }, _default: 'pending'

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :must_be_better_than_previous, on: :create

  def better_than_previous?
    previous_bid = Bid.where(carrier_id:, load_id:, route_id:)
                      .where.not(id:)
                      .order(created_at: :desc)
                      .first

    return true unless previous_bid

    amount < previous_bid.amount
  end

  def self.current_best_for(load_id, route_id)
    where(load_id:, route_id:, status: 'pending')
      .order(amount: :asc)
      .first
  end

  private

  def must_be_better_than_previous
    return if better_than_previous?

    errors.add(:amount, 'Your bid is higher than your previous bid for this route and load')
  end
end
