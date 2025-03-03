require 'rails_helper'

RSpec.describe Load, type: :model do
  describe 'associations' do
    it { should have_many(:bids).dependent(:destroy) }
    it { should have_many(:carriers).through(:bids) }
    it { should have_many(:routes).through(:bids) }
  end

  describe 'validations' do
    it { should validate_presence_of(:load_type) }
  end

  describe '#display_load_type' do
    it 'returns formatted load type for pallets5' do
      load = build(:load, load_type: 'pallets5')
      expect(load.display_load_type).to eq('5 pallets')
    end

    it 'returns formatted load type for pallets10' do
      load = build(:load, load_type: 'pallets10')
      expect(load.display_load_type).to eq('10 pallets')
    end

    it 'returns formatted load type for pallets26' do
      load = build(:load, load_type: 'pallets26')
      expect(load.display_load_type).to eq('26 pallets')
    end
  end
end
