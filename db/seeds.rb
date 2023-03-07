# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 # Gardens
Garden.create(name: "Turing Community Garden", organic: true)
Garden.create(name: "Maple Grove Community Garden", organic: false)
Garden.create(name: "Sunnyvale Community Garden", organic: true)

# Plots
Plot.create(number: 25, size: "Large", direction: "East", garden_id: 1)
Plot.create(number: 13, size: "Small", direction: "South", garden_id: 2)
Plot.create(number: 7, size: "Medium", direction: "West", garden_id: 3)

# Plants
Plant.create(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 100)
Plant.create(name: "Green Zebra Tomato", description: "Fruits ripen midseason, perfect for fresh salads.", days_to_harvest: 75)
Plant.create(name: "Dragon Tongue Bush Bean", description: "Tender and stringless, great for canning.", days_to_harvest: 60)
Plant.create(name: "San Marzano Tomato", description: "A traditional Italian variety, great for sauces", days_to_harvest: 80)
Plant.create(name: "Meyer Lemon Tree", description: "Produces fragrant, juicy lemons year-round", days_to_harvest: 365)
Plant.create(name: "Rainbow Swiss Chard", description: "Brightly colored and nutrient-rich", days_to_harvest: 60)

# PlotPlants
PlotPlant.create(plot_id: 1, plant_id: 1)
PlotPlant.create(plot_id: 1, plant_id: 2)
PlotPlant.create(plot_id: 1, plant_id: 3)
PlotPlant.create(plot_id: 1, plant_id: 4)
PlotPlant.create(plot_id: 2, plant_id: 1)
PlotPlant.create(plot_id: 2, plant_id: 5)
PlotPlant.create(plot_id: 3, plant_id: 3)
PlotPlant.create(plot_id: 3, plant_id: 6)
