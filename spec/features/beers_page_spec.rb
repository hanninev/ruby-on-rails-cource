require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery }

  it "can be added when name is a valid." do
    visit new_beer_path
    fill_in('beer[name]', with:'testiolut')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "can't be added when name is a invalid and an error message is given." do
    visit new_beer_path
    fill_in('beer[name]', with:'')

    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    expect(page).to have_content 'Name is too short'
  end
end