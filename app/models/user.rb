class User < ActiveRecord::Base
  has_many :reservations
  has_many :reviews
  has_one :payment_info
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable         
end
