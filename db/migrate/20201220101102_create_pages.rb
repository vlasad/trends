class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.references :category, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.string :code, null: false
      t.string :content_url, null: false
      t.string :title, null: false
      t.string :description
      t.string :keywords
      t.string :meta_image_url

      t.timestamps
    end
    add_index :pages, :code, unique: true
  end
end
