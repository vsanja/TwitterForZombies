class TweetsController < ApplicationController

  before_filter :get_zombie

  def get_zombie
    @zombie = Zombie.find(params[:zombie_id])
  end

  def index
    @tweets = Tweet.includes(:location).recent
  end

  def show
    @tweet = @zombie.tweets.find(params[:id])
  end

  def create
    @tweet = @zombie.tweets.new(params[:tweet])

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to [@zombie, @tweet], notice: 'Tweet was successfully created.' }
        format.json { render json: [@zombie, @tweet], status: :created, location: [@zombie, @tweet] }
      else
        format.html { render action: "new" }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
end