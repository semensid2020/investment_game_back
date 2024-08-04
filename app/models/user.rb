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


  # Возможно эти 2 методы не могут быть приватными!!!
  def buy_tokens(amount_of_dollars, market)
    tokens_to_buy = amount_of_dollars / market.price
    if capital >= amount_of_dollars
      update(capital: capital - amount_of_dollars, amount_of_tokens: amount_of_tokens + tokens_to_buy)
    else
      false
    end
  end

  def sell_tokens(amount_of_dollars, market)
    dollars_to_receive = amount_of_dollars * market.price
    if amount_of_tokens >= amount_of_dollars
      update(capital: capital + dollars_to_receive, amount_of_tokens: amount_of_tokens - amount_of_dollars)
    else
      false
    end
  end

end
