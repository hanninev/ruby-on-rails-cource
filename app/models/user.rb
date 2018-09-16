require 'concerns/rating_average'

class User < ApplicationRecord
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, maxinum: 50 }

  has_many :ratings
end
