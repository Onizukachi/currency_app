class CurrencyRatesController < ApplicationController
  def index
    data = CurrencyRate.last_month
    @chart_data = prepare_data_for_chart data
  end

  def last_four_weeks
    data = CurrencyRate.last_four_weeks
    @table_data = prepare_data_for_table data
  end

  private

  def prepare_data_for_chart(data)
    header = ['x', data.map(&:date).uniq.sort].flatten
    body = data.group_by { |x| x.currency }
                        .transform_values { |x| x.sort_by(&:date).map { |el| el.rate.to_f.round(2)} }
                        .to_a.map(&:flatten)

    body.unshift(header).to_json
  end

  def prepare_data_for_table(data)
    filtered_rows = data.select { |row| row.date.sunday? || row.date.monday? }

    filtered_rows.group_by { |row| row.currency }
                 .transform_values { |v| v.sort_by(&:date).each_slice(2).map { |x| [x.last.rate, get_percent(x.first.rate, x.last.rate)] }}
  end

  def get_percent(a, b)
    (((b - a)) / a * 100).to_f.round(1)
  end
end
