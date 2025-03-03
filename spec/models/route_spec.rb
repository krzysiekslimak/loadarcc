require 'rails_helper'

RSpec.describe Route, type: :model do
  describe 'associations' do
    it { should have_many(:bids).dependent(:destroy) }
    it { should have_many(:carriers).through(:bids) }
    it { should have_many(:loads).through(:bids) }
  end

  describe 'validations' do
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
  end
end
