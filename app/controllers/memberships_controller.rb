class MembershipsController < ApplicationController
    def index
      @memberships = Membership.all
    end
  
    def new
      @membership = Membership.new
      @beer_clubs = BeerClub.all
    end
  
    def create
      @membership = Membership.new params.require(:membership).permit(:beer_club_id)
      @membership.user = current_user
    
      if @membership.save
        redirect_to user_path current_user
      else
        @beer_clubs = BeerClub.all
        render :new
      end
    end
  
    def destroy
      rating = Rating.find(params[:id])
      rating.delete
      redirect_to user_path(current_user)
    end
  end
  