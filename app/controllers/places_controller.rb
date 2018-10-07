class PlacesController < ApplicationController
    before_action :set_place, only: [:show, :edit, :update, :destroy]
    
    def index
    end

    def show
    end
  
    def search
      @weather = WeatherApi.get_weather_in(params[:city])
      @places = BeermappingApi.places_in(params[:city])
      session[:city] = params[:city]

      if @places.empty?
        redirect_to places_path, notice: "No locations in #{params[:city]}"
      else
        render :index
      end
    end

    def set_place
        @place = BeermappingApi.get_place(session[:city], params[:id])
    end
  end