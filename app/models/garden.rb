class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def plants_listed
    plants.select("plants.*, COUNT(DISTINCT plot_plants.plot_id) AS plot_count")
    .where("days_to_harvest < 100")
    .group("plants.id")
    .order("plot_count DESC")
  end
end