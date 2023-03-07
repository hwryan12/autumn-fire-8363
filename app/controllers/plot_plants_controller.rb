class PlotPlantsController < ApplicationController
  def destroy
    @plot_plant = PlotPlant.find_by(plot: params[:plot_id], plant: params[:plant_id])
    @plot_plant.destroy
    redirect_to "/plots"
  end
end