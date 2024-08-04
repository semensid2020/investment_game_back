class MarketsController < ApplicationController
  before_action :set_market, only: [:show, :buy, :sell, :next_date]

  def show
    @balance = (current_user.capital - 10000.to_d).to_i
  end

  def buy
    if current_user.buy_tokens(params[:amount_of_dollars_for_buying].to_f, @market)
      redirect_to market_path(@market), notice: 'Transaction completed successfully.'
    else
      redirect_to market_path(@market), notice: 'Not enough capital to buy tokens.'
    end

  end

  def sell
    if current_user.sell_tokens(params[:amount_of_tokens_for_selling].to_i, @market)
      redirect_to market_path(@market), notice: 'Transaction completed successfully.'
    else
      redirect_to market_path(@market), notice: "Not enough tokens to sell."
    end
  end

  def next_date
    @market.calculate_next_date

    redirect_to market_path(@market), notice: "Today's date is #{@market.current_date}"
  end

  private

  def set_market
    @market = current_user.market
  end
end
