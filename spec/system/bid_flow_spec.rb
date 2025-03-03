require 'rails_helper'

RSpec.describe 'Bid flow', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let!(:carrier) { create(:carrier, carrier_name: 'Test Carrier') }
  let!(:route) { create(:route, from: 'Berlin', to: 'Warsaw') }
  let!(:load) { create(:load, load_type: 'pallets5') }

  scenario 'User submits a new bid' do
    visit bids_path(carrier_id: carrier.id)

    expect(page).to have_content('Currently logged in as: Test Carrier')

    select 'Berlin → Warsaw', from: 'Route'
    select '5 pallets', from: 'Load Type'
    fill_in 'Bid Amount ($)', with: '100'

    click_button 'Submit Bid'

    expect(page).to have_content('Bid was successfully created')
    expect(page).to have_content('Berlin → Warsaw')
    expect(page).to have_content('5 pallets')
    expect(page).to have_content('$100.00')
  end

  scenario 'User tries to submit a higher bid than their previous one' do
    create(:bid, carrier:, route:, load:, amount: 100)

    visit bids_path(carrier_id: carrier.id)

    select 'Berlin → Warsaw', from: 'Route'
    select '5 pallets', from: 'Load Type'

    # Disable JavaScript validation to allow form submission
    page.execute_script("document.querySelector('form').noValidate = true;")

    # Fill in the amount field with a higher value
    fill_in 'Bid Amount ($)', with: '110'

    # Submit the form
    click_button 'Submit Bid'

    # Check if the error message appears
    expect(page).to have_content('Your bid must be lower than your previous bid for the same route and load')
  end

  scenario 'User submits a better bid from the current bids section' do
    create(:bid, carrier:, route:, load:, amount: 100)

    visit bids_path(carrier_id: carrier.id)

    # Wait for the page to load and find the "Your Current Bids" section
    expect(page).to have_content('Your Current Bids')

    # Find the accordion button and click it
    first('.accordion-button').click

    # Wait for the section to expand
    expect(page).to have_selector('.accordion-collapse.show')

    # Fill in the form in the expanded section
    within('.accordion-collapse.show') do
      fill_in 'bid[amount]', with: '90'
      click_button 'Submit Bid'
    end

    expect(page).to have_content('Bid was successfully created')
    expect(page).to have_content('$90.00')
  end
end
