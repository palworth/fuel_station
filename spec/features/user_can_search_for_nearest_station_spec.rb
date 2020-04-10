require 'rails_helper'

describe "user can visit the welcome page" do
  scenario "selects turing from dropdown and searches" do
    visit '/'
    within '#location' do
      find("option[value='1331 17th St LL100, Denver, CO 80202']").click
    end
    click_button 'Find Nearest Station'
    save_and_open_page
    expect(current_path).to eq('/search')
    expect(page).to have_content("Nearest Fuel Station")
    expect(page).to have_content("Search For The Nearest Electric Charging Station")
    expect(page).to have_button("Find Nearest Station")
  end
end
