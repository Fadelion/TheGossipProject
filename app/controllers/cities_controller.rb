class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = Gossip.joins(:user).where(users: { city_id: @city.id })
  end
end