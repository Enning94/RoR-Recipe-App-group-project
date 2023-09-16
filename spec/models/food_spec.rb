# /spec/model/food_spec.rb
require 'rails_helper'

RSpec.describe Food, type: :model do
  user = FactoryBot.create(:user)
  food = FactoryBot.build(:food, user:)
  before { food.save }

  it 'is valid with valid attributes' do
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food.name = nil
    expect(food).to_not be_valid
  end

  it 'is not valid with a name less than 3 characters' do
    food.name = 'ab'
    expect(food).to_not be_valid
  end

  it 'is not valid with a name more than 50 characters' do
    food.name = 'a' * 51
    expect(food).to_not be_valid
  end

  it 'is valid with a name between 3 and 50 characters' do
    food.name = 'a' * 10
    expect(food).to be_valid
  end

  it 'is not valid without a measurement_unit' do
    food.measurement_unit = nil
    expect(food).to_not be_valid
  end

  it 'is not valid with a measurement_unit less than 2 characters' do
    food.measurement_unit = 'a'
    expect(food).to_not be_valid
  end

  it 'is not valid with a measurement_unit more than 10 characters' do
    food.measurement_unit = 'a' * 11
    expect(food).to_not be_valid
  end

  it 'is valid with a measurement_unit between 2 and 10 characters' do
    food.measurement_unit = 'a' * 5
    expect(food).to be_valid
  end

  it 'is not valid without a price' do
    food.price = nil
    expect(food).to_not be_valid
  end

  it 'is not valid with a price less than 0' do
    food.price = -1
    expect(food).to_not be_valid
  end

  it 'is valid with a price greater than 0' do
    food.price = 1
    expect(food).to be_valid
  end

  it 'is valid with a price equal to 0' do
    food.price = 0
    expect(food).to be_valid
  end

  it 'is not valid with a price that is not a number' do
    food.price = 'a'
    expect(food).to_not be_valid
  end
end
