class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])  
    @fast_plants_list = @garden.plants_listed
  end
end