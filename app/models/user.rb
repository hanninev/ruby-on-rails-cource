require 'concerns/rating_average'

class User < ApplicationRecord
  include RatingAverage

  has_many :ratings
end
