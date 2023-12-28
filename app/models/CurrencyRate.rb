class CurrencyRate < ApplicationRecord
  validates :currency, :date, :rate, presence: true
  validates :rate, numericality: { greater_than: 0 }

  validates_uniqueness_of :date, scope: :rate
end
