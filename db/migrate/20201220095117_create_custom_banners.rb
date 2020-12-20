class CreateCustomBanners < ActiveRecord::Migration[6.1]
  def change
    create_table :custom_banners do |t|
      t.references :banner, null: false, foreign_key: true
      t.integer :views, null: false, default: 0
      t.integer :clicks, null: false, default: 0
      t.text :params

      t.timestamps
    end
  end
end
