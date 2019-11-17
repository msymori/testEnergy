class HousesController < ApplicationController

  def index
    @house = House.new
    @city_name = City.all
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
    @city_name = City.all
    @years = Energy.count_year(params[:id])
    @target_dates = Energy.get_data(params[:id], @years)
    @charts = []
    @month = []
    @daylight = []
    @energy = []
    
    @years.each do |y|
      (@target_dates.length).times do |i|
        if @target_dates[i][0].equal?(y.year) then
          @month << @target_dates[i][1]
          @energy << @target_dates[i][2]
          @daylight << @target_dates[i][3]
        end
      end
      @chart = get_chart_graph(y.year ,@month, @daylight, @energy)
      @charts << @chart
      @month = []
      @energy = []
      @daylight  = []
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
    def get_chart_graph(text, months, daylight, energy_production)
      @chart = LazyHighCharts::HighChart.new("graph") do |c|
        c.title(text: text)
        c.xAxis(categories: months)
        c.series(name: "energy_production", data: energy_production)
        c.series(name: "daylight", data: daylight, color: "red")
        c.chart(backgroundColor: 'lightgray')
      end
    end
end
