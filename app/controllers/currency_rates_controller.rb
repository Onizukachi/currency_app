class CurrencyRatesController < ApplicationController
  def index
    ApiServices::CbrWraper.get_rates_for_date(Date.current)
  end

  def rub

  end

  def usd

  end

  def eur

  end

  def cny

  end
end
