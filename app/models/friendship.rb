class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  #belongs_to :pending_friend, :class_name => "User"
end
