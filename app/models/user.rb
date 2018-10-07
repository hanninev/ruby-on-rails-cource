require 'concerns/rating_average'

class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3, maxinum: 50 }
  validates :password, length: { minimum: 4 }, format: { with: /.*[A-Z].*\d/, message: 'must contain an uppercase letter and a digit' }
  has_many :ratings
  has_many :membership
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :membership

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def average_of(ratings)
    ratings.sum(&:score).to_f / ratings.count
  end

  def favorite_style
    return nil if ratings.empty?

    style_ratings = ratings.group_by{ |r| r.beer.style }
    averages = style_ratings.map do |style, ratings|
      { style: style, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] }[:style]
  end

  def favorite_brewery
    return nil if ratings.empty?

    style_ratings = ratings.group_by{ |r| r.beer.brewery }
    averages = style_ratings.map do |brewery, ratings|
      { brewery: brewery, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] }[:brewery]
  end
end
