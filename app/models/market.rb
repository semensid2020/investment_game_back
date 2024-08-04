# == Schema Information
#
# Table name: markets
#
#  id            :bigint           not null, primary key
#  current_date  :date
#  price         :decimal(10, 2)
#  price_history :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_markets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Market < ApplicationRecord
  belongs_to :user

  def calculate_next_date
    new_date = current_date + 1.day

    new_price = VolatilityService.simulate

    update(current_date: new_date, price: new_price)
    price_history << { date: new_date.strftime('%d %b'), price: new_price.to_f }
    save
  end

end
