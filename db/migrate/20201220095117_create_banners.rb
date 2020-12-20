class CreateBanners < ActiveRecord::Migration[6.1]
  def change
    create_table :cbanners do |t|
      t.references :banner_type, null: false, foreign_key: true
      t.references :page, null: false, foreign_key: true
      t.string :code, limit: 16, null: false
      t.integer :views, null: false, default: 0
      t.integer :clicks, null: false, default: 0
      t.text :data

      t.timestamps
    end
    add_index :banners, :code, unique: true
  end
end
