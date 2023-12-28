class CreateCurrencyRates < ActiveRecord::Migration[7.1]
  def change
    create_table :currency_rates do |t|
      t.date :date, index: true
      t.string :currency
      t.decimal :rate
      t.timestamps
    end

    add_index :currency_rates, %i[date currency], unique: true
  end
end
