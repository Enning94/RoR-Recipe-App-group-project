class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 500 }
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :public, inclusion: { in: [true, false] }
end
