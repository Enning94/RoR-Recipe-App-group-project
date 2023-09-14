class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :foods
  has_many :recipes

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :password_confirmation, presence: true
end
