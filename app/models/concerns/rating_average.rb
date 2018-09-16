require 'active_support/concern'

module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    "Has #{ratings.length} #{'rating'.pluralize(ratings.length)}, avegage #{ratings.sum{|r| r.score} / ratings.count.to_f}"
  end

  def user_average_rating
    "Has made #{ratings.length} #{'rating'.pluralize(ratings.length)}, avegage #{ratings.sum{|r| r.score} / ratings.count.to_f}"
  end
end
