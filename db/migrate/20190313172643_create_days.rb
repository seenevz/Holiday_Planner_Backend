class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.time :planned_time
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
