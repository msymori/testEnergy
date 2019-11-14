class CityEnergy < ApplicationRecord
  belongs_to :city
  
  def sum_city_energy(id)
    sum = group('city_id').sum('energy_production')
    sum[id]
  end
end
