class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.string :code, limit: 256, null: false
      t.string :affiliate_url, null: false

      t.timestamps
    end
    add_index :offers, :code, unique: true
    add_index :offers, :affiliate_url, unique: true
  end
end
