class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :category_id
      t.string :name
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
