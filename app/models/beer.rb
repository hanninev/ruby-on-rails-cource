class Beer < ApplicationRecord
	belongs_to :brewery
	has_many :ratings

	def average_rating
		"Has #{self.ratings.length} #{"rating".pluralize(self.ratings.length)}, avegage #{self.ratings.sum { |r| r.score }/self.ratings.length}"
	end

end
