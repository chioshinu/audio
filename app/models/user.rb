class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  has_many :friendships, :class_name => "Friendship", :foreign_key => "user_id", :conditions => "confirmed = 't'"
  has_many :friends, :through => :friendships, :source => :friend
  has_many :pending_friendships, :class_name => "Friendship", :foreign_key => "user_id", :conditions => "confirmed = 'f'"
  has_many :pending_friends, :through => :friendships, :source => :friend
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user, :conditions => "confirmed = 't'"
  has_many :inverse_pending_friends, :through => :inverse_friendships, :source => :user, :conditions => "confirmed = 'f'"
end
