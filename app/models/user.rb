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
end
