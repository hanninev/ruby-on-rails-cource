class Beer < ApplicationRecord
  include RatingAverage
  extend Top

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }

  def to_s
    "#{name} #{brewery.name}"
  end
end
