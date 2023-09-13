json.extract! food, :id, :name, :price, :quantity, :measurement_unit, :user_id, :created_at, :updated_at
json.url food_url(food, format: :json)
