=begin
require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved if a name, brewery and style are given" do
    test_brewery = Brewery.new name: "test", year: 2000
    beer = Beer.create name:"Koff", brewery: test_brewery, style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved if a name isn't given" do
    test_brewery = Brewery.new name: "test", year: 2000
    beer = Beer.create brewery: test_brewery, style:"Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved if a style isn't given" do
    test_brewery = Brewery.new name: "test", year: 2000
    beer = Beer.create name:"Koff", brewery: test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
=end