require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all carriers' do
      carrier = create(:carrier)
      get :index
      expect(assigns(:carriers)).to include(carrier)
    end

    it 'assigns current carrier if carrier_id param is present' do
      carrier = create(:carrier)
      get :index, params: { carrier_id: carrier.id }
      expect(assigns(:current_carrier)).to eq(carrier)
    end

    it 'assigns all routes' do
      route = create(:route)
      get :index
      expect(assigns(:routes)).to include(route)
    end

    it 'assigns all loads' do
      load = create(:load)
      get :index
      expect(assigns(:loads)).to include(load)
    end

    it 'assigns a new bid' do
      get :index
      expect(assigns(:bid)).to be_a_new(Bid)
    end

    it 'assigns bids by combination' do
      route = create(:route)
      load = create(:load)
      bid = create(:bid, route:, load:)

      get :index

      expect(assigns(:bids_by_combination)).to have_key([route.id, load.id])

      expect(assigns(:bids_by_combination)[[route.id, load.id]]).to include(bid)
    end

    it 'assigns current carrier bids if current carrier is present' do
      carrier = create(:carrier)
      bid = create(:bid, carrier:)

      get :index, params: { carrier_id: carrier.id }
      expect(assigns(:current_carrier_bids)).to include(bid)
    end
  end

  describe 'POST #create' do
    let(:carrier) { create(:carrier) }
    let(:route) { create(:route) }
    let(:load) { create(:load) }
    let(:valid_attributes) { { carrier_id: carrier.id, route_id: route.id, load_id: load.id, amount: 100 } }

    context 'with valid params' do
      it 'creates a new Bid' do
        expect do
          post :create, params: { bid: valid_attributes }
        end.to change(Bid, :count).by(1)
      end

      it 'redirects to the bids index' do
        post :create, params: { bid: valid_attributes }
        expect(response).to redirect_to(bids_path(carrier_id: carrier.id))
      end
    end

    context 'with invalid params' do
      it 'does not create a new Bid' do
        expect do
          post :create, params: { bid: { amount: nil } }
        end.to change(Bid, :count).by(0)
      end

      it 're-renders the index template' do
        post :create, params: { bid: { amount: nil } }
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #previous_bid' do
    it 'returns JSON with previous bid amount' do
      carrier = create(:carrier)
      route = create(:route)
      load = create(:load)
      bid = create(:bid, carrier:, route:, load:, amount: 100)

      get :previous_bid, params: { carrier_id: carrier.id, route_id: route.id, load_id: load.id }
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['previous_bid_amount']).to eq(100.0)
    end

    it 'returns JSON with nil previous bid amount if no previous bid exists' do
      carrier = create(:carrier)
      route = create(:route)
      load = create(:load)

      get :previous_bid, params: { carrier_id: carrier.id, route_id: route.id, load_id: load.id }
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['previous_bid_amount']).to be_nil
    end
  end
end
