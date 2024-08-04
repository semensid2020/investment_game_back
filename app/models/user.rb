# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  amount_of_tokens :integer
#  capital          :decimal(10, 2)   default(10000.0)
#  name             :string
#  username         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  telegram_id      :bigint
#
class User < ApplicationRecord
  # Устанавливаем связь с моделью Market
  has_one  :market, dependent: :destroy

  private

  def create_market
    Market.create(user: self, current_date: 5.years.ago, price: 10)
  end
end
