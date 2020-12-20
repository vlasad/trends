class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :code, limit: 128, null: false

      t.timestamps
    end
    add_index :categories, :code, unique: true
  end
end
