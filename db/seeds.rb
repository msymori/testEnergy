# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'


# 重複のCityを取り除く
cities = Set[]
CSV.foreach('db/house_data.csv', headers: true) do |row|
  cities << row['City']
  cities.to_a().sort()
end

# Cityのデータ
all_cities = {}
for city in cities do
  all_cities[city] = City.create(
    name: city
    )
end

# Houseのデータ
city_of_houses = {}
CSV.foreach('db/house_data.csv', headers: true) do |row|
  house = House.create(
    firstname: row['Firstname'],
    lastname: row['Lastname'],
    city_id: all_cities[row['City']].id,
    num_of_people: row['num_of_people'],
    has_child: row['has_child'] == 'Yes' ? 1 : 0,
    )
  city_of_houses[house.id] = all_cities[row['City']]
end 

# Energyのデータ
CSV.foreach('db/dataset_50.csv', headers: true) do |row|
  Energy.create(
    label: row['Label'],
    house_id: row['House'],
    year: row['Year'],
    month: row['Month'],
    temperature: row['Temperature'],
    daylight: row['Daylight'],
    energy_production: row['EnergyProduction']
    )
    
  house_id = row['House'].to_i
  city_id = city_of_houses[house_id].id
  CityEnergy.create(
    city_id: city_id,
    year: row['Year'],
    month: row['Month'],
    energy_production: row['EnergyProduction']
    )
end 
