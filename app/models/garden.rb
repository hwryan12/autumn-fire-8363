class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def plants_listed
    plants.where("days_to_harvest < 100").distinct
    # binding.pry
  end
end
