require 'active_support/concern'

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    "Has #{ratings.length} #{'rating'.pluralize(ratings.length)}, avegage #{ratings.sum(r.score) / ratings.count.to_f}"
  end
end
