class Feedback < ActiveRecord::Base
  attr_accessible :email, :message

  validates :email, presence: true, email: true
  validates :message, presence: true, length: { minimum: 10, maximum: 2048 }
end
