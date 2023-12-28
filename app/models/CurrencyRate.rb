class CurrencyRate < ApplicationRecord
  validates :currency, :date, :rate, presence: true
  validates :rate, numericality: { greater_than: 0 }

  validates_uniqueness_of :date, scope: :rate

  scope :last_four_weeks, ->() { where(date: 4.weeks.ago.beginning_of_week..1.weeks.ago.end_of_week).order(:date) }
  scope :last_month, ->() { where(date: Date.current.beginning_of_month..Date.current).order(:date) }
end
