require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    before = User.count
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(before)
  end

  it "is not saved with too short or invalid password" do
    before = User.count

    lowerCasePassword = User.create username:"Pekka", password:"secret", password_confirmation:"secret"
    tooShortPassword = User.create username:"Pekka", password:"Se1", password_confirmation:"Se1"

    expect(lowerCasePassword).not_to be_valid
    expect(tooShortPassword).not_to be_valid
    expect(User.count).to eq(before)
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating({ user: user }, 10 )
      create_beer_with_rating({ user: user}, 7 )
      best = create_beer_with_rating({ user: user }, 25 )
    
      expect(user.favorite_beer).to eq(best)
    end    
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      before = User.count

      expect(user).to be_valid
      expect(User.count).to eq(before + 1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end