require 'active_support/concern'

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings.sum(&:score) / ratings.count.to_f
  end
end
