class ZombiesController < ApplicationController
  # GET /zombies
  # GET /zombies.json
  def index
    @zombies = Zombie.includes(:brain).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zombies }
    end
  end

  # GET /zombies/1
  # GET /zombies/1.json
  def show
    @zombie = Zombie.find(params[:id])

    respond_to do |format|
      format.html do
        if @zombie.decomp == 'Dead (again)'
          render :dead_again
        end
      end
      format.json { render json: @zombie }
    end
  end

  # GET /zombies/new
  # GET /zombies/new.json
  def new
    @zombie = Zombie.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @zombie }
    end
  end

  # GET /zombies/1/edit
  def edit
    @zombie = Zombie.find(params[:id])
  end

  # POST /zombies
  # POST /zombies.json
  def create
    @zombie = Zombie.new(params[:zombie])

    respond_to do |format|
      if @zombie.save
        format.html { redirect_to @zombie, notice: 'Zombie was successfully created.' }
        format.json { render json: @zombie, status: :created, location: @zombie }
      else
        format.html { render action: "new" }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PUT /zombies/1
  # PUT /zombies/1.json
  def update
    @zombie = Zombie.find(params[:id])

    respond_to do |format|
      if @zombie.update_attributes(params[:zombie])
        format.html { redirect_to @zombie, notice: 'Zombie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zombies/1
  # DELETE /zombies/1.json
  def destroy
    @zombie = Zombie.find(params[:id])
    @zombie.destroy

    respond_to do |format|
      format.html { redirect_to zombies_url }
      format.json { head :no_content }
      format.js
    end
  end

  def decomp
    @zombie = Zombie.find(params[:id])
    if @zombie.decomp == 'Dead (again)'
      render json: @zombie.to_json(only: :decomp),
             status: :unprocessable_entity
    else
      render json: @zombie.to_json(only: :decomp)
    end
  end

  def custom_decomp
    @zombie = Zombie.find(params[:id])
    @zombie.decomp = params[:zombie][:decomp]
    @zombie.save

    respond_to do |format|
      format.html { redirect_to zombies_url }
      format.js
      format.json { render json: @zombie.to_json(only: :decomp) }
    end
  end

end