class CurrencyRatesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def index
    @chart_data = data_for_chart
    # shows = number_to_currency(rows.first.rate, precision: 2, unit: "₽", format: "%n %u")
  end

  def get_percent(a, b)
    (((b - a)) / a * 100).to_f.round(1)
  end


  def rub

  end

  def usd

  end

  def eur

  end

  def cny

  end

  private

  def data_for_chart
    rows = CurrencyRate.where(date: 4.weeks.ago.beginning_of_week.. 1.weeks.ago.end_of_week).order(:date)
    filtered_rows = rows.select { |row| row.date.sunday? || row.date.monday? }

    header = ['x', filtered_rows.map(&:date).uniq.sort].flatten
    body = filtered_rows.group_by { |x| x.currency }
                        .transform_values { |x| x.sort_by(&:date).map(&:rate) }
                        .to_a.map(&:flatten)

    body.unshift(header).to_json
  end

  def data_for_table
    rows = CurrencyRate.where(date: 4.weeks.ago.beginning_of_week.. 1.weeks.ago.end_of_week).order(:date)

    result = rows.to_a.group_by { |row| row.currency }
                 .transform_values { |v|  v.each_slice(7).to_a
                                           .map { |week_arr| [week_arr.first.rate, week_arr.last.rate, get_percent(week_arr.first.rate, week_arr.last.rate)] } }
  end
end
