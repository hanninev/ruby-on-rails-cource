require 'active_support/concern'

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    if (ratings.sum(&:score) / ratings.count.to_f).nan?
      0
    else
      ratings.sum(&:score) / ratings.count.to_f
    end
  end
end
