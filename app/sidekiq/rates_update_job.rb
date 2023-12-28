class RatesUpdateJob
  include Sidekiq::Job

  def perform(*args)
    results = ApiServices::CbrWraper.get_rates_for_date
    results.each do |hash|
      new_rate = CurrencyRate.new(hash.merge(date: Date.today))
      new_rate.save
    rescue => error
      next
    end
  end
end

