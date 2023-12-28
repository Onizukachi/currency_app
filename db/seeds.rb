date_range = (1.month.ago.to_date..Date.today)

date_range.each do |date|
  results = ApiServices::CbrWraper.get_rates_for_date date

  results.each do |hash|
    new_rate = CurrencyRate.new(hash.merge(date:))
    new_rate.save!

  rescue ActiveRecord::RecordInvalid
    next
  end
end
