class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :city
      t.string :mood
      t.integer :number_people
      t.date :begin_date
      t.date :end_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
