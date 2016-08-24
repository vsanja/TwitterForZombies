class Zombie < ActiveRecord::Base
  attr_accessor :age, :bio, :name

  has_one :brain, dependent: :destroy
  has_many :assignments
  has_many :roles, through: :assignments
  has_many :weapons


  scope :rotting, where(rotting: true)
  scope :fresh, where("age < 20")
  scope :recent, order("created_at desc").limit(3)

  before_save :make_rotting

  def make_rotting
    self.rotting = true if age > 20
  end

  def as_json(options = nil)
    super(options || {include: :brain, except: [:created_at, :updated_at, :id]})
  end
end