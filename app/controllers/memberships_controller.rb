class MembershipsController < ApplicationController
    def index
      @memberships = Membership.all
    end
  
    def new
      @membership = Membership.new
      @beer_clubs = BeerClub.all.select{|bc| !current_user.beer_clubs.include? bc}
    end
  
    def create
      @membership = Membership.new params.require(:membership).permit(:beer_club_id)
      @membership.user = current_user
      
      if !current_user.beer_clubs.include? @membership.beer_club
      if @membership.save
        redirect_to user_path current_user
      else  
        @beer_clubs = BeerClub.all.select{|bc| !current_user.beer_clubs.include? bc}
        render :new
      end
    end
      
      
    end
  
    def destroy
      rating = Rating.find(params[:id])
      rating.delete
      redirect_to user_path(current_user)
    end
  end
  