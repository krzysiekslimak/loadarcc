Rails.application.routes.draw do
  resources :carriers, only: %i[index new create]
  resources :bids, only: %i[index new create] do
    collection do
      get :previous_bid
    end
  end

  root 'bids#index'
end
