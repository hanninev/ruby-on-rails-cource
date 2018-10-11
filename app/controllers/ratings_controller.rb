class RatingsController < ApplicationController
  def index
    Rails.cache.write("ratings", Rating.all) if !fragment_exist?("ratingslist")
    @ratings = Rails.cache.read "ratings"

    Rails.cache.write("best_beers", Beer.all.reject{ |b| b.ratings.empty? }.sort_by{ |b| -b.average_rating }.first(3)) if !fragment_exist?("ratingslist")
    @best_beers = Rails.cache.read "best_beers"

    Rails.cache.write("best_breweries", Brewery.all.reject{ |b| b.ratings.empty? }.sort_by{ |b| -b.average_rating }.first(3)) if !fragment_exist?("ratingslist")
    @best_breweries = Rails.cache.read "best_breweries"

    Rails.cache.write("best_styles", Style.all.reject{ |b| b.ratings.empty? }.sort_by{ |b| -b.average_rating }.first(3)) if !fragment_exist?("ratingslist")
    @best_styles = Rails.cache.read "best_styles"

    Rails.cache.write("most_ratings", User.all.reject{ |b| b.ratings.empty? }.sort_by{ |b| -b.ratings.count }.first(3)) if !fragment_exist?("ratingslist")
    @most_ratings = Rails.cache.read "most_ratings"

    Rails.cache.write("last_three", Rating.all.last(3)) if !fragment_exist?("ratingslist")
    @last_three = Rails.cache.read "last_three"
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
