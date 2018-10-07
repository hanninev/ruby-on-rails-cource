class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
  end

  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all.reject{ |bc| current_user.beer_clubs.include? bc }
  end

  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    @membership.user = current_user

    respond_to do |format|
      if !current_user.beer_clubs.include?(@membership.beer_club) && @membership.save
        format.html { redirect_to beer_club_path(@membership.beer_club), notice: "#{current_user.username} welcome to beer club!" }
        format.json { render :show, status: :created, location: @beer_club }
      else
        @beer_clubs = BeerClub.all.reject{ |bc| current_user.beer_clubs.include? bc }
        format.html { render :new }
      end
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to user_path(current_user)
  end
end
