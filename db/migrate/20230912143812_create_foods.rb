class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :price
      t.decimal :quantity
      t.string :measurement_unit
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
