require 'rails_helper'

RSpec.describe Carrier, type: :model do
  describe 'associations' do
    it { should have_many(:bids).dependent(:destroy) }
    it { should have_many(:routes).through(:bids) }
    it { should have_many(:loads).through(:bids) }
  end

  describe 'validations' do
    it { should validate_presence_of(:carrier_name) }
    it { should validate_uniqueness_of(:carrier_name) }
  end
end
