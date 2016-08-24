class Tweet < ActiveRecord::Base
  attr_accessible :status, :zombie_id

  has_one :location, foreign_key: :tweeter_id, dependent: :destroy
  has_many :categorizations
  has_many :categories, through: :categorizations

  before_save :has_location
  def has_location
    self.show_location = true if self.location?
  end

  after_update :log_update
  after_destroy :log_destroy

  def log_update
    logger.info "Tweet #{id} updated"
  end

  def log_destroy
    logger.info "Tweet #{id} deleted"
  end

  scope :recent, order('created_at desc').limit(4)
  scope :graveyard, where(show_location: true, location: "graveyard")
end