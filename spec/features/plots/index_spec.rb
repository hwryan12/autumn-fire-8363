require 'rails_helper'

RSpec.describe "Plots Index" do
  let!(:garden) { Garden.create(name: "Turing Community Garden", organic: true) }

  let!(:plot_1) { garden.plots.create(number: 1, size: "Large", direction: "East") }
  let!(:plot_2) { garden.plots.create(number: 2, size: "Large", direction: "North") }
  let!(:plot_3) { garden.plots.create(number: 3, size: "Medium", direction: "East") }
  let!(:plot_4) { garden.plots.create(number: 4, size: "Small", direction: "South") }

  let!(:plant_1) { Plant.create(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90) }
  let!(:plant_2) { Plant.create(name: "Gold Potatoes", description: "Just stick it in the ground.", days_to_harvest: 120) }
  let!(:plant_3) { Plant.create(name: "Basil", description: "Prefers indirect sun.", days_to_harvest: 60) }
  let!(:plant_4) { Plant.create(name: "Sunflowers", description: "Prefers lots and lots of sun.", days_to_harvest: 50) }

  before do 
    plot_1.plot_plants.create!(plant: plant_1)
    plot_1.plot_plants.create!(plant: plant_2)
    plot_1.plot_plants.create!(plant: plant_3)

    plot_2.plot_plants.create!(plant: plant_2)
    
    plot_3.plot_plants.create!(plant: plant_3)
    plot_3.plot_plants.create!(plant: plant_4)

    visit '/plots'
  end 

  describe "User Story 1" do
    context "As a visitor" do
      context "When I visit the plots index page ('/plots')" do
        it "I see a list of all plot numbers
          And under each plot number I see the names of all that plot's plants" do
          
          expect(page).to have_content("Plot Number: 1")
          expect(page).to have_content("Plot Number: 2")
          expect(page).to have_content("Plot Number: 3")
    
          within("##{plot_1.id}") do
            expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
            expect(page).to have_content("Gold Potatoes")
            expect(page).to have_content("Basil")

            expect(page).to_not have_content("Sunflowers")
          end

          within("##{plot_2.id}") do
            expect(page).to have_content("Gold Potatoes")

            expect(page).to_not have_content("Purple Beauty Sweet Bell Pepper")
            expect(page).to_not have_content("Sunflowers")
            expect(page).to_not have_content("Basil")
          end

          within("##{plot_3.id}") do
            expect(page).to have_content("Basil")
            expect(page).to have_content("Sunflowers")

            expect(page).to_not have_content("Purple Beauty Sweet Bell Pepper")
            expect(page).to_not have_content("Gold Potatoes")
          end

          within("##{plot_4.id}") do
            expect(page).to have_content("")
          end
        end
      end
    end
  end

  describe "User Story 2" do
    context "As a visitor" do
      context "When I visit the plots index page ('/plots')" do
        it "Next to each plant's name I see a link to remove that plant from that plot
          When I click on that link I'm returned to the plots index page and I no longer see that plant listed under that plot,
          And I still see that plant's name under other plots that is was associated with." do
         
          within("##{plot_1.id}") do
            expect(page).to have_link("Remove Purple Beauty Sweet Bell Pepper")
            expect(page).to have_link("Remove Gold Potatoes")
            expect(page).to have_link("Remove Basil")

            click_link("Remove Basil")

            expect(current_path).to eq('/plots')
            expect(page).to_not have_content("Basil")
            expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
            expect(page).to have_content("Gold Potatoes")
          end
          
          within("##{plot_3.id}") do
            expect(page).to have_link("Remove Basil")
            expect(page).to have_link("Remove Sunflowers")

            click_link("Remove Sunflowers")

            expect(current_path).to eq('/plots')
            expect(page).to_not have_content("Sunflowers")
            expect(page).to have_content("Basil")
          end

          within("##{plot_2.id}") do
            expect(page).to have_link("Remove Gold Potatoes")

            click_link("Remove Gold Potatoes")

            expect(current_path).to eq('/plots')
            expect(page).to_not have_content("Gold Potatoes")
          end

          within("##{plot_4.id}") do
            expect(page).to have_content("")
          end
        end
      end
    end
  end
end