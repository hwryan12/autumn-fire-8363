require 'rails_helper'

RSpec.describe "Gardens Show" do
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

  describe "User Story 3" do
    context "As a visitor" do
      context "When I visit a garden's show page" do
        it "Then I see a list of plants that are included in that garden's plots
          And I see that this list is unique (no duplicate plants)
          And I see that this list only includes plants that take less than 100 days to harvest" do
          visit "/gardens/#{garden.id}"

          expect(page).to have_content("Plant Name: Purple Beauty Sweet Bell Pepper").once
          expect(page).to have_content("Description: Prefers rich, well draining soil").once
          expect(page).to have_content("Days until ready to harvest: 90").once
          
          expect(page).to have_content("Plant Name: Basil").once
          expect(page).to have_content("Description: Prefers indirect sun.").once
          expect(page).to have_content("Days until ready to harvest: 60").once
          
          expect(page).to_not have_content("Plant Name: Gold Potatoes")
          expect(page).to_not have_content("Description: Just stick it in the ground.")
          expect(page).to_not have_content("Days until ready to harvest: 120")
          
          expect(page).to_not have_content("Plant Name: Sunflowers")
          expect(page).to_not have_content("Description: Prefers lots and lots of sun.")
          expect(page).to_not have_content("Days until ready to harvest: 100")
        end
      end
    end
  end

  describe "Extension" do
    context "As a visitor" do
      context "When I visit a garden's show page" do
        it "Then I see the list of plants is sorted by the number of times the plant 
          appears in any of that garden's plots from most to least" do
          plant_5 = Plant.create(name: "Green Zebra Tomato", description: "Fruits ripen midseason, perfect for fresh salads.", days_to_harvest: 75)

          plot_2.plot_plants.create!(plant: plant_3)
          plot_2.plot_plants.create!(plant: plant_5)

          plot_3.plot_plants.create!(plant: plant_5)

          visit "/gardens/#{garden.id}"

          expect(plant_3.name).to appear_before(plant_5.name)
          expect(plant_5.name).to appear_before(plant_1.name)
        end
      end
    end
  end
end