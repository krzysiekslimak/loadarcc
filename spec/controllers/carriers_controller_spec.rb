require 'rails_helper'

RSpec.describe CarriersController, type: :controller do
  describe 'GET #index' do
    it 'assigns all carriers' do
      carrier = create(:carrier)
      get :index
      expect(assigns(:carriers)).to include(carrier)
    end
  end

  describe 'GET #new' do
    it 'assigns a new carrier' do
      get :new
      expect(assigns(:carrier)).to be_a_new(Carrier)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { { carrier_name: 'Test Carrier', email: 'test@example.com' } }

      it 'creates a new Carrier' do
        expect do
          post :create, params: { carrier: valid_attributes }
        end.to change(Carrier, :count).by(1)
      end

      it 'redirects to the carriers index' do
        post :create, params: { carrier: valid_attributes }
        expect(response).to redirect_to(carriers_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Carrier' do
        expect do
          post :create, params: { carrier: { carrier_name: nil } }
        end.to change(Carrier, :count).by(0)
      end

      it 're-renders the new template' do
        post :create, params: { carrier: { carrier_name: nil } }
        expect(response).to render_template(:new)
      end
    end
  end
end
