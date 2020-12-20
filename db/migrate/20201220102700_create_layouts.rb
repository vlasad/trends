class CreateLayouts < ActiveRecord::Migration[6.1]
  def change
    create_table :layouts do |t|
      t.string :file_name, null: false

      t.timestamps
    end
    add_index :layouts, :file_name, unique: true
  end
end
