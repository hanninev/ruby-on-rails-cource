class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, length: { minimum: 1 }
  validates :year, numericality: { greater_than_or_equal_to: 1040, less_than_or_equal_to: :this_year }

  include RatingAverage

  def this_year
    Time.now.year
  end
end
