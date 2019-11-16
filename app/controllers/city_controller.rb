require "city_energy.rb"

class CityController < ApplicationController
  def index
    @cities_name = City.all
    @cities_energy = CityEnergy.sum_cities_energy()
    @energy_count = CityEnergy.group('city_id').count
  end
  
  def new
    @city = City.new
  end 
  
  def create
    @city = City.new(city_params)
    if @city.save
      flash[:success] = 'Create City!!'
      redirect_to root_url
    else
      flash.now[:danger] = 'Not Create City...'
      render root_url
    end
  end
  
  
  def city_params
    params.require(:city).permit(:name)
  end
end
