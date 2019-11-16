class HousesController < ApplicationController
  
  def index
    @house = House.new
    @city_name = City.all
    @houses = House.all
  end
  
  def show
    @house = House.find(params[:id])
    @city_name = City.all
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
end
