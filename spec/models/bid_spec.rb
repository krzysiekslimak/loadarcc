require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe 'associations' do
    it { should belong_to(:carrier) }
    it { should belong_to(:route) }
    it { should belong_to(:load) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe '#better_than_previous?' do
    let(:carrier) { create(:carrier) }
    let(:route) { create(:route) }
    let(:load) { create(:load) }

    context 'when there is no previous bid' do
      it 'returns true' do
        bid = build(:bid, carrier:, route:, load:, amount: 100)
        expect(bid.better_than_previous?).to be true
      end
    end

    context 'when the new bid is lower than the previous bid' do
      it 'returns true' do
        create(:bid, carrier:, route:, load:, amount: 100)
        bid = build(:bid, carrier:, route:, load:, amount: 90)
        expect(bid.better_than_previous?).to be true
      end
    end

    context 'when the new bid is higher than the previous bid' do
      it 'returns false' do
        create(:bid, carrier:, route:, load:, amount: 100)
        bid = build(:bid, carrier:, route:, load:, amount: 110)
        expect(bid.better_than_previous?).to be false
      end
    end

    context 'when the new bid is equal to the previous bid' do
      it 'returns false' do
        create(:bid, carrier:, route:, load:, amount: 100)
        bid = build(:bid, carrier:, route:, load:, amount: 100)
        expect(bid.better_than_previous?).to be false
      end
    end
  end

  describe '.current_best_for' do
    let(:route) { create(:route) }
    let(:load) { create(:load) }

    it 'returns the lowest bid for a given route and load' do
      bid1 = create(:bid, route:, load:, amount: 100)
      bid2 = create(:bid, route:, load:, amount: 90)
      bid3 = create(:bid, route:, load:, amount: 110)

      expect(Bid.current_best_for(load.id, route.id)).to eq(bid2)
    end

    it 'returns nil if there are no bids' do
      expect(Bid.current_best_for(load.id, route.id)).to be_nil
    end
  end

  describe 'must_be_better_than_previous validation' do
    let(:carrier) { create(:carrier) }
    let(:route) { create(:route) }
    let(:load) { create(:load) }

    it 'is valid when the bid is better than the previous bid' do
      create(:bid, carrier:, route:, load:, amount: 100)
      bid = build(:bid, carrier:, route:, load:, amount: 90)
      expect(bid).to be_valid
    end

    it 'is invalid when the bid is not better than the previous bid' do
      create(:bid, carrier:, route:, load:, amount: 100)
      bid = build(:bid, carrier:, route:, load:, amount: 110)
      expect(bid).not_to be_valid
      expect(bid.errors[:amount]).to include('Your bid is higher than your previous bid for this route and load')
    end
  end
end
