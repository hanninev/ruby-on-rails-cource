class BeerClub < ApplicationRecord
    has_many :membership
    has_many :users, through: :membership

  def to_s
    self.name
  end
end
