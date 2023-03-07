require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  let!(:garden) { Garden.create(name: "Turing Community Garden", organic: true) }

  let!(:plot_1) { garden.plots.create(number: 1, size: "Large", direction: "East") }
  let!(:plot_2) { garden.plots.create(number: 2, size: "Large", direction: "North") }
  let!(:plot_3) { garden.plots.create(number: 3, size: "Medium", direction: "East") }

  let!(:plant_1) { Plant.create(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90) }
  let!(:plant_2) { Plant.create(name: "Gold Potatoes", description: "Just stick it in the ground.", days_to_harvest: 120) }
  let!(:plant_3) { Plant.create(name: "Basil", description: "Prefers indirect sun.", days_to_harvest: 60) }
  let!(:plant_4) { Plant.create(name: "Sunflowers", description: "Prefers lots and lots of sun.", days_to_harvest: 100) }

  before do 
    plot_1.plot_plants.create!(plant: plant_1)
    plot_1.plot_plants.create!(plant: plant_2)
    plot_1.plot_plants.create!(plant: plant_3)
    plot_2.plot_plants.create!(plant: plant_2)
    plot_3.plot_plants.create!(plant: plant_3)
    plot_3.plot_plants.create!(plant: plant_4)
  end 
  describe "#plants_listed" do

    it "returns only the plants in a garden that take less than 100 days to harvest" do
      expect(garden.plants_listed).to eq([plant_1, plant_3])
      expect(garden.plants_listed).to_not eq([plant_1, plant_2, plant_3, plant_4])
    end
  end
end
