class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :title
      t.string :mood
      t.string :number_people
      t.string :begin_date
      t.string :end_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
