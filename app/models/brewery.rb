class Brewery < ApplicationRecord
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def average_rating
		"Has #{self.ratings.length} #{"rating".pluralize(self.ratings.length)}, avegage #{self.ratings.sum { |r| r.score }/self.ratings.length}"
	end
end
