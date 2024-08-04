class CreateMarkets < ActiveRecord::Migration[7.0]
  def change
    create_table :markets do |t|
      t.date        :current_date
      t.decimal     :price, precision: 10, scale: 2
      t.references  :user, null: true, foreign_key: true
      t.json        :price_history, default: []

      t.timestamps
    end
  end
end
