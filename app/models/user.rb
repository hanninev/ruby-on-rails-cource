require 'concerns/rating_average'

class User < ApplicationRecord
  include RatingAverage

  has_secure_password                  

  validates :username, uniqueness: true,
                       length: { minimum: 3, maxinum: 50 }
  validates :password, length: { minimum: 4 }, format: { with: /.*[A-Z].*\d/, message: 'must contain an uppercase letter and a digit' }
  has_many :ratings
  has_many :membership
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :membership
end
