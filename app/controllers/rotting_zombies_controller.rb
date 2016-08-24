class RottingZombiesController < ApplicationController

  def index
    @rotting_zombies = Zombie.rotting

  end

  def update
    @zombie = Zombie.find(params[:id])

    respond_to do |format|
      if @zombie.update_attributes(params[:zombie])
        #...
      else
        #...
      end
    end
  end
end
