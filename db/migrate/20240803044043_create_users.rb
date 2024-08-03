class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :username
      t.bigint  :telegram_id
      t.decimal :capital, precision: 10, scale: 2, default: 10000.to_d
      t.integer :amount_of_tokens

      t.timestamps
    end
  end
end
