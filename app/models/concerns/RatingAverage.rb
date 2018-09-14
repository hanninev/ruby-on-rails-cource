require 'active_support/concern'

module RatingAverage
    extend ActiveSupport::Concern

	def average_rating
		"Has #{self.ratings.length} #{"rating".pluralize(self.ratings.length)}, avegage #{self.ratings.sum { |r| r.score }/self.ratings.length}"
    end
    
end