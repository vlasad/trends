class CreateBanners < ActiveRecord::Migration[6.1]
  def change
    create_table :banners do |t|
      t.string :file_name, null: false
      t.integer :views, null: false, default: 0
      t.integer :clicks, null: false, default: 0

      t.timestamps
    end
    add_index :banners, :file_name, unique: true
  end
end
