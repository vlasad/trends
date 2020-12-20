class CreateBannerTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :banner_types do |t|
      t.string :file_name, null: false
      t.integer :views, null: false, default: 0
      t.integer :clicks, null: false, default: 0

      t.timestamps
    end
    add_index :banner_types, :file_name, unique: true
  end
end
