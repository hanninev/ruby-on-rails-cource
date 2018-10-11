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
        format.html { redirect_to beer_club_path(@membership.beer_club), notice: "#{current_user.username}, your membership is waiting for accepting!" }
        format.json { render :show, status: :created, location: @beer_club }
      else
        @beer_clubs = BeerClub.all.reject{ |bc| current_user.beer_clubs.include? bc }
        format.html { render :new }
      end
    end
  end

  def destroy
    @ms = Membership.all.where(id: params.require(:id)).first
    @ms.destroy
    respond_to do |format|
      format.html { redirect_to @ms.user, notice: "Membership in #{@ms.beer_club.name} ended" }
      format.json { head :no_content }
    end
  end

  def toggle_confirm
    membership = Membership.find params[:id]
    membership.update_attribute :confirmed, !membership.confirmed

    new_status = membership.confirmed? ? "confirmed" : "unconfirmed"

    redirect_to beer_club_path(membership.beer_club_id), notice: "membership is #{new_status}"
  end
end
