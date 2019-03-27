class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.integer :place_id
      t.integer :city_id
      t.string :name
      t.string :image
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
